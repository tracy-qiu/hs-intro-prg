//
//  Rover.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

class Rover: Mine {
    var direction: Direction?
    var moveActions = [MoveAction]()
    
    init(row: Int, col: Int, energy: Int, id: String, direction: Direction?) {
        self.direction = direction
        super.init(row: row, col: col, objectType: .Rover, energy: energy, id: id)
    }
    
    final func addMove(instruction: MoveAction) {
        moveActions.append(instruction)
    }
}

