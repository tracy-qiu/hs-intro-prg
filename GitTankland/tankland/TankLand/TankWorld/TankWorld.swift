//
//  Grid.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

class TankWorld {
    var grid: [[GameObject?]]
    var mineGrid: [[GameObject?]]
    var turn: Int
    var numberCols: Int
    var numberRows: Int
    var constants = Constants()
    var messageCenter = MessageCenter()
    var logger = [Logger]()
    var gameOver = false
    var lastLivingTank = Tank(row: 0, col: 0, energy: 0, id: "last tank", instructions: "")
    
    // useful properties here
    
    init(numberRows: Int, numberCols: Int){
        self.numberRows = numberRows
        self.numberCols = numberCols
        self.turn = 0
        self.grid = Array(repeating: Array(repeating: nil, count: numberCols), count: numberRows)
        self.mineGrid = Array(repeating: Array(repeating: nil, count: numberCols), count: numberRows)
    }
    
    func setWinner(lastTankStanding: Tank) {
        gameOver = true
        lastLivingTank = lastTankStanding
    }
    func addGameObject(gameObject: GameObject) {
        var logger = getLogAtTurn()
        logger.addMajorLog(gameObject, "Added to Tankland")
        logger.numberOfTanks += 1
        grid[gameObject.position.row][gameObject.position.col] = gameObject
    }
    func removeGameObject(gameObject: GameObject) {
        var logger = getLogAtTurn()
        logger.addLog(gameObject, "\(gameObject.id) has died")
        grid[gameObject.position.row][gameObject.position.col] = nil
    }
    
    func doTurn() {
        let allGameObjects = findAllGameObjects(grid: grid, numberRows: numberRows, numberCols: numberCols)
        let allRandomObjects = randomizeGameObjects(gameObjects: allGameObjects)
        let allRovers = findAllRovers(grid: grid, numberRows: numberRows, numberCols: numberCols)
        let allTanks = findAllTanks(grid: grid, numberRows: numberRows, numberCols: numberCols)
        var allRandomTanks = randomizeGameObjects(gameObjects: allTanks)
        var logger = getLogAtTurn()
        logger.numberOfTanks = numberOfLivingTanks(grid: grid, numberRows: numberRows, numberCols: numberCols)
        // randomize
        for object in allGameObjects {
            chargeLifeSupport(object: object)
        }
        for r in allRovers {
            if let rover = r as? Rover {
                let moveActions = rover.moveActions
                for move in moveActions {
                    let nextPosition = newPosition(position: rover.position, direction: move.direction, magnitude: move.distance)
                    let oldPosition = rover.position
                    rover.setPosition(newPosition: nextPosition)
                    grid[rover.position.row][rover.position.col] = grid[oldPosition.row][oldPosition.col]
                    grid[oldPosition.row][oldPosition.col] = nil
                }
            }
        }
        
        for tank in allRandomTanks {
            tank.clearActions()
            let preActions = tank.computePreActions()
            let preActionOrder: [Actions] = [.Radar, .SendMessage, .ReceiveMessage, .Shields]
            for actionType in preActionOrder {
                if let preAction = preActions[actionType] {
                    doPreAction(preAction: preAction, tank: tank)
                }
            }
            let postActions = tank.computePostActions()
            let postActionOrder: [Actions] = [.DropMine, .Missile, .Move]
            for actionType in postActionOrder {
                if let postAction = postActions[actionType] {
                    doPostAction(postAction: postAction, tank: tank)
                }
            }
            if tank.energy <= 0 && allRandomTanks.count > 1 {
                removeGameObject(gameObject: tank)
            }
            if allRandomTanks.count == 1 {
                lastLivingTank = tank
                setWinner(lastTankStanding: tank)
            }
        }
        turn += 1
    }
    
    func printReport(cellSizeWidth: Int, cellSizeLength: Int) {
        for log in logger {
            print(log)
            print(printGrid(cellSizeWidth: cellSizeWidth, cellSizeLength: cellSizeLength))
        }
    }
    
    func driver(cellSizeWidth: Int, cellSizeLength: Int, numberOfTurns: Int) {
        turn = 1
        while !gameOver && turn < numberOfTurns + 1 {
            doTurn()
//            printReport(cellSizeWidth: cellSizeWidth, cellSizeLength: cellSizeLength)
        }
        printReport(cellSizeWidth: cellSizeWidth, cellSizeLength: cellSizeLength)
        if !gameOver {
            print("Game over, no more turns, max turn \(numberOfTurns)!")
        } else {
            print("***Winner is ... \(lastLivingTank.id)")
        }
        
    }
    
    struct MessageStatus {
        var isRead: Bool
        var message: String
        
        init(message: String) {
            self.message = message
            self.isRead = false
        }
        
        mutating func changeStatus(isRead: Bool = true) {
            self.isRead = isRead
        }
    }
    
    struct MessageCenter {
        var messages = [String: MessageStatus]()
        
        mutating func sendMessage(id: String, message: String) {
            messages[id] = MessageStatus(message: message)
        }
        
        mutating func receivedMessage(id: String) -> String? {
            if var messageStatus = messages[id] {
                messageStatus.changeStatus()
                return messageStatus.message
            }
            return nil
        }
    }
}


