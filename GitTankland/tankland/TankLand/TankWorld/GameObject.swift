//
//  Properties.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

// handle method, tank does something with the addPreActions/addPostActions
// TankWorld is running a turn, runs actions for all the tanks
// relating handleradar and actions
// doesn't matter what order they do preactions, postactions are randomized, movement of rovers are randomized
// as soon as energy goes below 0 or at 0 it is instantly dead
// final func = if you inherit this you cannot override it
// turn coordinate to direction and distance -- only straight lines

import Foundation

enum GameObjectType {
    case GameObjectType, Mine, Rover, Tank
}
class GameObject: CustomStringConvertible {
    let objectType: GameObjectType
    private (set) var energy: Int
    let id: String
    private (set) var position: Position
    
    init(row: Int, col: Int, objectType: GameObjectType, energy: Int, id: String) {
        self.objectType = objectType
        self.energy = energy
        self.id = id
        self.position = Position(row: row, col: col)
    }
    
    final func die() {
        energy = 0
    }
    
    final func addEnergy(amount: Int) {
        energy += amount
    }
    final func useEnergy(amount: Int) {
        energy = (amount > energy) ? 0 : energy - amount
    }
    final func setPosition(newPosition: Position) {
        position = newPosition
    }
    
    var description: String {
        return "\(objectType) \(energy) \(id) \(position)"
    }
}

