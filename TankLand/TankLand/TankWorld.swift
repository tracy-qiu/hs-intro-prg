//
//  TankWorld.swift
//  TankLand
//
//  Created by Tracy Qiu on 4/30/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

class TankWorld {
    var grid: [[GameObject?]]
    var turn: Int
    var numberCols: Int
    var numberRows: Int

    init(){
        self.numberCols = numberCols
        self.numberRows = numberRows
        grid = Array(repeating: Array(repeating: nil, count: numberCols), count: numberRows)
    }

    func setWinner(lastTankStanding: Tank) {
        gameOver = true
        lastLivingTank = lastTankStanding
    }

    func populateTankWorld(){

    }
    func addGameObject(gameObject: GameObject){
        logger.addMajorLog(gameObject, "Addes to TankLand")
        grid[gameObject.position.row] [gameObject.position.col] = gameObject
        if gameObject.objectType == .Tank{numberLivingTanks += 1}
    }

    func handleRadar (tank: Tank) {
        guard let radarAction = tank.preActions[.Radar] else {return}
        actionRunRadar(tank: tank, radarAction: radarAction as! RadarAction)
    }

    func doTurn() {
        var allObject = findAllGameObjects()
        allObjects = randomizeGameObjects(gameObjects: allObjects)
        turn += 1
    }

    func runOneTurn() {
        doTurn()
        print (gridReport())
    }

    func driver(){
        populatetankWorld()
        print (gridReport())
        while !gameOver {
            //this while look is the driver for tankland
        }
        print ("***Winner is ... \(lastLivingTank!)")
    }

    //TankWorldSupport.swift
    extension TankWorld{
    //put the support code methods in this file
    }
    //TankWorldDisplay.swift
    extension TankWorld{
    //put the code to display the grid in this file
    }
    //TankWorldActions.swift
    extension TankWorld{
        //put the code to run action in this file. A few sample actions are given
        func actionSendMessage(tank:Tank, sendMessageAction: SendMessageAction){
            logger.addLog(tank, "Sending Message \(sendMessageAction)")

            if !isEnergyAvaliable(tank, amount: Constants.costOfSendingMessage) {
                logger.addLog(tank, "Insufficient energy to send message")
                return
            }
            applyCost(tank, amount: Constants.costOfSendingMessage)
            MessageCenter.sendMessage(id: sendMessageAction.id, message: sendMessage.message)
        }
        func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction){
            if isDead(tank) {return}
            logger.addLog(tank, "Receiving Message \(receiveMessageAction)")

            if !isEnergyAvaliable(tank, amount: Constants.costOfReceivingMessage){
                logger.addLog(tank, "Insufficient energy to send message")
                return
            }
            applyCost(tank, amount: Constants.costOfReveivingMessage)
            let message = MessageCenter.receiveMessage(id: receiveMessageAction.id)
            tank.setReceiveMessage(receivedMessage: message)
        }

    }

}
struct MessageStatus {
    var message: String
    var isRead: Bool
    
    init(message: String){
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
    mutating func receiveMessage(id: String) {
        messages[id]!.changeStatus()
    }
}

class SampleTank: Tank {
    override init(row: Int, col: Int, energy:  Int, id: String, instructions: String){
        super.init(row: row, col: col, energy: energy, id: id, instructions)
    }
    
    func chanceOf (percent: Int)-> Bool {
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    override func computePreActions() {
        addPreAction(preAction: SheildAction(power: 300))
        addPreAction(preAction: RadarAction(range: 4))
        super.computePreActions()
    }
    
    override func computePostActions() {
        if (chanceOf(percent: 50)) {
            let randomDirection = Direction(rawValue: getRandomInt(range: 7))!
            addPostAction(postAction: MoveAction(distance: 2, direction: randomDirection))
        }
        super.computePostActions()
        
        guard let rs = radarResults, rs.count != 0 else {return}
        if energy < 5000 {return}
        
        if (chanceOf(percent: 50)) {return}
        let randomItem = rs[getRandomInt(range: rs.count)]
        let missileEnergy = energy > 20000 ? 1000 : (energy/20)
        addPostAction(postAction: MissileAction(power: missileEnergy, target: randomItem.position))
    }
}









