//
//  main.swift
//  TankLand
//
//  Created by Jennifer W. on 4/9/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

enum Direction {
    case North, Northeast, East, Southeast, South, Southwest, West, Northwest
}

let numberOfCol = 15
let numberOfRow = 15
let cellSizeWidth = 7
let cellSizeLength = 4
class GUPI: Tank {
    override init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        super.init(row: row, col: col, energy: energy, id: id, instructions: instructions)
    }
    func chanceOf(percent: Int)-> Bool {
        let ran = getRandomInt(range: 300)
        return percent <= ran
    }
    override func computePreActions() -> [Actions : PreAction] {
        if energy > 5000 {
            addPreAction(preAction: ShieldAction(power: 100))
            addPreAction(preAction: RadarAction(range: 3))
        }
        return super.computePreActions()
    }
    
    override func computePostActions() -> [Actions : PostAction] {
        guard let rs = self.radarResult, rs.result.count != 0 else {
            return super.computePostActions()
        }
        
        // Results
        let results = rs.result
        
        // Collect mines and tanks
        var mines = [GameObject?]()
        var tanks = [GameObject?]()
        for item in results {
            if item.objectType == .Mine {
                mines.append(item)
            }
            if item.objectType == .Tank {
                tanks.append(item)
            }
        }
        
        if (chanceOf(percent: 20)) {
            for m in mines {
                if let position = m?.position {
                    var newPos = newPosition(position: self.position, direction: .Northeast, magnitude: 1)
                    if position.isSamePosition(newPos) {
                        addPostAction(postAction: MoveAction(distance: 1, direction: .Northeast))
                    }
                }
            }
        }
        if energy > 7000 {
            let randomResult = results[getRandomInt(range: results.count)]
            if randomResult.objectType == .Tank {
                addPostAction(postAction: MissileAction(power: 100, target: randomResult.position))
            }
            if energy > 500 && energy < 1000 {
                addPostAction(postAction: DropMineAction(power: 200, isRover: false, dropDirection: .Southwest, moveDirection: nil))
            }
        }
        return super.computePostActions()
    }
}

let gupi1 = GUPI(row: 2, col: 4, energy: 10000, id: "G1", instructions: "Gupi shall survive!")
let gupi2 = GUPI(row: 5, col: 7, energy: 10000, id: "G2", instructions: "Gupi shall survive!")
let gupi3 = GUPI(row: 9, col: 3, energy: 10000, id: "G3", instructions: "Gupi shall survive!")

class SampleTank: Tank {
    override init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        super.init(row: row, col: col, energy: energy, id: id, instructions: instructions)
    }
    
    func chanceOf(percent: Int) -> Bool {
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    override func computePreActions() -> [Actions : PreAction] {
        addPreAction(preAction: ShieldAction(power: 300))
        addPreAction(preAction: RadarAction(range: 4))
        return super.computePreActions()
    }
    
    override func computePostActions() -> [Actions : PostAction] {
        if (chanceOf(percent: 50)) {
            let randomDirection = getRandomDirection()!
            addPostAction(postAction: MoveAction(distance: 2, direction: randomDirection))
        }
        guard let rs = radarResult, rs.result.count != 0 else{
            return super.computePostActions()
        }
        if energy < 5000 {
            return super.computePostActions()
        }
        if (chanceOf(percent: 50)) {
            return super.computePostActions()
        }
        
        var results = rs.result
        let randomItem = results[getRandomInt(range: results.count)]
        let missileEnergy = energy > 20000 ? 1000 : (energy / 20)
        addPostAction(postAction: MissileAction(power: missileEnergy, target: randomItem.position))
        return super.computePostActions()
    }
}

var tankWorld1 = TankWorld(numberRows: 15, numberCols: 15)
let S1 = SampleTank(row: 3, col: 5, energy: 10000, id: "S1", instructions: "")
let S2 = SampleTank(row: 6, col: 9, energy: 10000, id: "S2", instructions: "")
let S3 = SampleTank(row: 2, col: 4, energy: 10000, id: "S3", instructions: "")

tankWorld1.addGameObject(gameObject: gupi1)
tankWorld1.addGameObject(gameObject: gupi2)
tankWorld1.addGameObject(gameObject: gupi3)
tankWorld1.addGameObject(gameObject: S1)
tankWorld1.addGameObject(gameObject: S2)
tankWorld1.addGameObject(gameObject: S3)
tankWorld1.driver(cellSizeWidth: 7, cellSizeLength: 4, numberOfTurns: 20)



