//
//  Tank.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

class Tank: GameObject {
    private (set) var shields: Int = 0
    var radarResult: RadarResult?
    private var receivedMessage: String?
    private (set) var preActions = [Actions : PreAction]()
    private (set) var postActions  = [Actions: PostAction]()
    private let initialInstructions: String?
    
    
    init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        initialInstructions = instructions
        radarResult = RadarResult()
        super.init(row: row, col: col, objectType: .Tank, energy: energy, id: id)
    }
    final func clearActions() {
        preActions = [Actions : PreAction]()
        postActions = [Actions : PostAction]()
    }
    final func setRadarResult(radarResult: RadarResult) {self.radarResult = radarResult}
    func setShields(shieldPower: Int) {self.shields = shieldPower}
    func useShield(energy: Int) {
        if (self.shields - energy) <= 0 {
            self.shields = 0
        }
        self.shields -= energy
    }
    final func receiveMessage(message: String) {receivedMessage = message}
    
    func computePreActions() -> [Actions : PreAction] {
        return self.preActions
    }
    
    func computePostActions() -> [Actions : PostAction] {
        return self.postActions
    }
    final func addPreAction(preAction: PreAction) {
        preActions[preAction.action] = preAction
    }
    final func addPostAction(postAction: PostAction) {
        postActions[postAction.action] = postAction
    }
    final func setReceivedMessage(receivedMessage: String) {
        self.receivedMessage = receivedMessage
    }
}



//class SampleTank: Tank {
//    override init(row: Int, col: Int, energy:  Int, id: String, instructions: String){
//        super.init(row: row, col: col, energy: energy, id: id, instructions)
//    }
//    
//    func chanceOf (percent: Int)-> Bool {
//        let ran = getRandomInt(range: 100)
//        return percent <= ran
//    }
//    
//    override func computePreActions() {
//        addPreAction(preAction: SheildAction(power: 300))
//        addPreAction(preAction: RadarAction(range: 4))
//        super.computePreActions()
//    }
//    
//    override func computePostActions() {
//        if (chanceOf(percent: 50)) {
//            let randomDirection = Direction(rawValue: getRandomInt(range: 7))!
//            addPostAction(postAction: MoveAction(distance: 2, direction: randomDirection))
//        }
//        super.computePostActions()
//        
//        guard let rs = radarResults, rs.count != 0 else {return}
//        if energy < 5000 {return}
//        
//        if (chanceOf(percent: 50)) {return}
//        let randomItem = rs[getRandomInt(range: rs.count)]
//        let missileEnergy = energy > 20000 ? 1000 : (energy/20)
//        addPostAction(postAction: MissileAction(power: missileEnergy, target: randomItem.position))
//}

