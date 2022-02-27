//
//  GameObject.swift
//  TankLand
//
//  Created by Tracy Qiu on 5/2/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

enum GameObjectType {
    case Mine, Tank, Rover
}


class GameObject: CustomStringConvertible {
    let objectType: GameObjectType?
    private (set) var energy: Int
    let id: String
    private (set) var position: Position
    
    init(row: Int, col: Int, objectType: GameObjectType, name: String, energy: Int, id: String) {
        self.objectType = objectType
        self.energy = energy
        self.id = id
        self.position = Position(row: row, col: col)
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
    func die(GO: GameObject){
        if energy <= 0 {
            exit(0)
        }
    }
    func living(GO: GameObject){
        while energy > 0 {
        }
    }
    func isDead(_ gameObject: GameObject) -> Bool {
        let GO: GameObject
        return GO.energy == 0
    }
    func isEnergyAvailable(_ gameObject: GameObject, amount: Int) -> Bool {
        var gameObject: GameObject
        var amount = GO.energy
        return amount != 0
    }
    
    var description: String {
        return "\(objectType) \(energy) \(id) \(position)"
    }
}
