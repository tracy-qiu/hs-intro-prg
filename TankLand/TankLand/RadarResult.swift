//
//  RadarResult.swift
//  TankLand
//
//  Created by Tracy Qiu on 5/16/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

struct RadarResult {
    var GO: GameObject
    var result: [GameObject]
    var position: Position
    var row: Int
    var col: Int
  
    init(GO: GameObject){
        self.GO = GO
        self.result = []
    }
    
    mutating func runRadar(row: Int, col: Int, distance: Int) -> [GameObject]{
        var cost = (2^(distance-1)) * 100
        var distance: Int 
        
            for row in position.row{
                for col in position.col{
                    if Position.GameObject != nil {
                        result += [Position.GameObject]
                    }
                }
            energy -= cost
        }
        position = GO.position
        
    }
        func distance(_ p1: Position, _ p2: Position) -> Int {
            var distance: Int
            var x: Int
            var y: Int
            x = (p1.row - p2.row)*(p1.row - p2.row)
            y = (p1.col - p2.col)*(p1.col - p2.col)
            distance = Int(sqrt(Double(x+y)))
            return distance
        }
}
