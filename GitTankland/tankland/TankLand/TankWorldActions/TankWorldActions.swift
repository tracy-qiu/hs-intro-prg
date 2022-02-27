//
//  TankWorldActions.swift
//  TankLand
//
//  Created by Jennifer W. on 5/1/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//
// radar -- if you touch it
// distance -- round down, use Int
//

import Foundation

enum Actions {
    case
    SendMessage, ReceiveMessage, Radar, Shields,
    DropMine, Move, Missile
}

protocol Action: CustomStringConvertible {
    var action: Actions {get}
    var description: String {get}
}

protocol PreAction: Action {
}

protocol PostAction: Action {
}

struct MoveAction: PostAction {
    let action: Actions
    let distance: Int
    let direction: Direction
    var description: String  {
        return "\(action) \(distance) \(direction)"
    }
    
    init(distance: Int, direction: Direction) {
        action = .Move
        self.distance = distance
        self.direction = direction
    }
}

struct ShieldAction: PreAction {
    let action: Actions
    let power: Int
    var description: String {
        return "\(action) \(power)"
    }
    init (power: Int){
        action = .Shields
        self.power = power
    }
}

struct MissileAction: PostAction{
    let action: Actions
    let power: Int
    let target: Position
    var description: String{
        return "\(action) \(power) \(target)"
    }
    init (power: Int, target: Position){
        action = .Missile
        self.power = power
        self.target = target
    }
}

struct RadarAction: PreAction{
    let action: Actions
    let range: Int
    var description: String{
        return "\(action) \(range)"
    }
    init (range: Int) {
        action = .Radar
        self.range = range
    }
}

struct SendMessageAction: PreAction {
    let action: Actions
    let key: String
    let message: String
    var description: String{
        return "\(action) \(key) \(message)"
    }
    init (key: String, message: String){
        action = .SendMessage
        self.key = key
        self.message = message
    }
}

struct ReceiveMessageAction: PreAction {
    let action: Actions
    let key: String
    var description: String{
        return "\(action) \(key)"
    }
    init (key: String) {
        action = .ReceiveMessage
        self.key = key
    }
}

struct DropMineAction: PostAction{
    let action: Actions
    let isRover: Bool
    let power: Int
    let dropDirection: Direction?
    let moveDirection: Direction?
    
    var description: String{
        let dropDirectionMessage = (dropDirection == nil) ? "drop direction is random" : "\(dropDirection!)"
        let moveDirectionMessage = (moveDirection == nil) ? "move direction is random" : "\(moveDirection!)"
        return "\(action) \(power) \(dropDirectionMessage) \(isRover) \(moveDirectionMessage)"
    }
    init (power:Int, isRover: Bool = false, dropDirection: Direction? = nil, moveDirection: Direction? = nil){
        action = .DropMine
        self.isRover = isRover
        self.dropDirection = dropDirection
        self.moveDirection = moveDirection
        self.power = power
    }
}

extension TankWorld {
    func getLogAtTurn() -> Logger {
        if turn < logger.count {
            return logger[turn]
        } else {
            let log = Logger(turnNum: turn)
            
            self.logger.append(log)
            return log
        }
    }
    
    func chargeLifeSupport(object: GameObject) {
        let logger = getLogAtTurn()
        switch object.objectType {
        case .Tank:
            logger.addLog(object, "Life Support")
            let initialEnergy = object.energy
            object.useEnergy(amount: constants.costLifeSupportTank)
            let finalEnergy = object.energy
            logger.addLog(object, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        case .Rover:
            logger.addLog(object, "Life Support")
            let initialEnergy = object.energy
            object.useEnergy(amount: constants.costLifeSupportRover)
            let finalEnergy = object.energy
            logger.addLog(object, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        case .Mine:
            logger.addLog(object, "Life Support")
            let initialEnergy = object.energy
            object.useEnergy(amount: constants.costLifeSupportMine)
            let finalEnergy = object.energy
            logger.addLog(object, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        default:
            return
        }
    }
    
    func actionRunRadar(tank: Tank, radarAction: RadarAction) {
        let logger = getLogAtTurn()
        logger.addLog(tank, "Running Radar with range of \(radarAction.range)")
        if !isEnergyAvailable(tank, amount: constants.costOfRadarByUnitsDistance[radarAction.range]) {
            logger.addLog(tank, "Insufficient energy to run radar")
            return
        }
        var radarResult = RadarResult()
        let gameObjects = findAllGameObjects(grid: grid, numberRows: numberRows, numberCols: numberCols)
        for GO in gameObjects {
            if radarResult.findDistance(tank.position, GO.position) <= radarAction.range {
                radarResult.addGO(GO)
            }
        }
        tank.setRadarResult(radarResult: radarResult)
        let initialEnergy = tank.energy
        tank.useEnergy(amount: constants.costOfRadarByUnitsDistance[radarAction.range])
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
    }
    func actionSendMessage(tank: Tank, sendMessageAction: SendMessageAction){
        let logger = getLogAtTurn()
        logger.addLog(tank, "Sending Message from \(tank.id)")
        
        if !isEnergyAvailable(tank, amount: constants.costOfSendingMessage) {
            logger.addLog(tank, "Insufficient energy to send message")
            return
        }
        let initialEnergy = tank.energy
        tank.useEnergy(amount: constants.costOfSendingMessage)
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        messageCenter.sendMessage(id: sendMessageAction.key, message: sendMessageAction.message)
    }
    
    func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction) {
        let logger = getLogAtTurn()
        if isDead(tank) {return}
        
        if !isEnergyAvailable(tank, amount: constants.costOfReceivingMessage){
            logger.addLog(tank, "Insufficient energy to receive message")
            return
        }
        if let receiveMessage = messageCenter.receivedMessage(id: receiveMessageAction.key) {
            logger.addLog(tank, "\(tank.id) received message: \(receiveMessage)")
        }
        let initialEnergy = tank.energy
        tank.useEnergy(amount: constants.costOfReceivingMessage)
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        tank.receiveMessage(message: receiveMessageAction.key)
        messageCenter.receivedMessage(id: receiveMessageAction.key)
    }
    
    func actionSetShields(tank: Tank, shieldAction: ShieldAction) {
        let logger = getLogAtTurn()
        if !isEnergyAvailable(tank, amount: shieldAction.power) {
            logger.addLog(tank, "Insufficient energy to set shield")
            return
        }
        logger.addLog(tank, "Setting shields to \(shieldAction.power * constants.shieldPowerMultiple)")
        tank.setShields(shieldPower: shieldAction.power * constants.shieldPowerMultiple)
        let initialEnergy = tank.energy
        tank.useEnergy(amount: shieldAction.power)
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
    }
    
    func doPreAction(preAction: PreAction, tank: Tank) {
        switch preAction.action {
        case .Radar:
            if let radarAction = preAction as? RadarAction {
                actionRunRadar(tank: tank, radarAction: radarAction)
            }
        case .SendMessage:
            if let sendMessageAction = preAction as? SendMessageAction {
                actionSendMessage(tank: tank, sendMessageAction: sendMessageAction)
                
            }
        case .ReceiveMessage:
            if let receiveMessageAction = preAction as? ReceiveMessageAction {
                actionReceiveMessage(tank: tank, receiveMessageAction: receiveMessageAction)
            }
        case .Shields:
            if let shieldAction = preAction as? ShieldAction {
                actionSetShields(tank: tank, shieldAction: shieldAction)
            }
        default:
            return
        }
    }
    
    func doTankMove(tank: Tank, moveAction: MoveAction) {
        let logger = getLogAtTurn()
        if moveAction.distance <= 0 {
            return
        }
        if !isEnergyAvailable(tank, amount: constants.costOfMovingTankPerUnitDistance[moveAction.distance - 1]) {
            logger.addLog(tank, "Insufficient energy to move tank")
            return
        }
        let nextPosition = newPosition(
            position: tank.position,
            direction: moveAction.direction,
            magnitude: moveAction.distance)
        if !isValidPosition(nextPosition, numberRows: numberRows, numberCols: numberCols) {
            return
        }
        if grid[nextPosition.row][nextPosition.col] != nil {
            let objectInPosition = (grid[nextPosition.row][nextPosition.col])!
            if objectInPosition.objectType == .Mine || objectInPosition.objectType == .Rover {
                if let mineObject = objectInPosition as? Mine {
                    if tank.shields > 0 {
                        tank.useShield(energy: mineObject.energy * constants.mineStrikeMultiple)
                    }
                    if tank.shields <= 0 {
                        tank.useEnergy(amount: mineObject.energy * constants.mineStrikeMultiple)
                    }
                    mineObject.explode()
                }
            }
        } else {
            let oldPosition = tank.position
            tank.setPosition(newPosition: nextPosition)
            grid[tank.position.row][tank.position.col] = grid[oldPosition.row][oldPosition.col]
            grid[oldPosition.row][oldPosition.col] = nil
            logger.addLog(tank, "Moving from \(oldPosition.Position()) to \(nextPosition.Position())")
            let initialEnergy = tank.energy
            tank.useEnergy(amount: constants.costOfMovingTankPerUnitDistance[moveAction.distance - 1])
            let finalEnergy = tank.energy
            logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        }
    }
    
    func doDropMine(tank: Tank, mineAction: DropMineAction) {
        let logger = getLogAtTurn()
        let adjacentPos = adjacentPosition(tank.position)
        if !isEnergyAvailable(tank, amount: constants.costOfReleasingRover) {
            logger.addLog(tank, "Insufficient energy to drop mine")
            return
        }
        if !isValidPosition(adjacentPos, numberRows: numberRows, numberCols: numberCols) {
            logger.addLog(tank, "Invalid position to drop mine")
        }
        logger.addLog(tank, "Dropping mine at \(adjacentPos.Position())")
        let initialEnergy = tank.energy
        tank.useEnergy(amount: Constants.costOfReleasingMine)
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        let power = mineAction.power
        grid[tank.position.row][adjacentPos.col] = Mine(row: tank.position.row,
                                                        col: tank.position.col,
                                                        objectType: .Mine,
                                                        energy: (power * constants.mineStrikeMultiple),
                                                        id: "\(tank.id)'s mine")
    }
    
    func doMissile(missileAction: MissileAction, tank: Tank) {
        let logger = getLogAtTurn()
        logger.addLog(tank, "Attempted Missile Launch from \(tank.id) \(tank.position.Position()) to \(missileAction.target.Position()) with energy \(missileAction.power * constants.missileStrikeMultiple)")
        let initialEnergy = tank.energy
        tank.useEnergy(amount: constants.costOfLaunchingMissile)
        let finalEnergy = tank.energy
        logger.addLog(tank, "Energy drop from \(initialEnergy) to \(finalEnergy)")
        let missilePosition = missileAction.target
        if grid[missilePosition.row][missilePosition.col] != nil {
            if let targetTank = grid[missilePosition.row][missilePosition.col] as? Tank {
                targetTank.useEnergy(amount: missileAction.power)
                logger.addLog(targetTank, "Energy drop to \(targetTank.energy)")
            }
        }
    }
    
    func doPostAction(postAction: PostAction, tank: Tank) {
        switch postAction.action {
        case .DropMine:
            if let dropMineAction = postAction as? DropMineAction {
                doDropMine(tank: tank, mineAction: dropMineAction)
            }
        case .Missile:
            if let missileAction = postAction as? MissileAction {
                doMissile(missileAction: missileAction, tank: tank)
            }
        case .Move:
            if let moveAction = postAction as? MoveAction {
                doTankMove(tank: tank, moveAction: moveAction)
            }
        default:
            return
        }
    }
    
}





