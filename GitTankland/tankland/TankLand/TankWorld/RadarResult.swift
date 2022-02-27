//
//  RadarResult.swift
//  TankLand
//
//  Created by Tracy Qiu on 6/7/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

//import Foundation
//
//struct RadarResult {
//    var GO: GameObject
//    var result: [GameObject]
//    var row: Int
//    var col: Int
//    var grid: [[GameObject?]]
//    var distance: Int
//
//    init(GO: GameObject, distance: Int){
//        self.GO = GO
//        self.result = []
//        self.distance = distance
//        self.grid = [[]]
//        self.row = GO.position.row
//        self.col = GO.position.col
//    }
//
//    mutating func runRadar(GO: GameObject, distance: Int) -> [GameObject]{
//        let gameObjects = findAllGameObjects(grid: grid, numberRows: row, numberCols: col)
//
//        for GO2 in gameObjects {
//            if  findDistance(GO.position, GO2.position) <= distance {
//               result += [GO2]
//            }
//        }
//        var costOfRadarByUnitsDistance = [0, 100, 200, 400, 800, 1600, 3200, 6400, 12400]
//        GO.useEnergy(amount: costOfRadarByUnitsDistance[distance])
//        return result
//    }
//
//    func findDistance(_ p1: Position, _ p2: Position) -> Int {
//        var distance: Int
//        var x: Int
//        var y: Int
//        x = (p1.row - p2.row)*(p1.row - p2.row)
//        y = (p1.col - p2.col)*(p1.col - p2.col)
//        distance = Int(sqrt(Double(x+y)))
//        return distance
//    }
//}
//RadarResult.swift
import Foundation

struct RadarResult {
    var result = [GameObject]()
    
    mutating func addGO(_ gameObject: GameObject) {
        self.result.append(gameObject)
    }
    
    func findDistance(_ p1: Position, _ p2: Position) -> Int {
        var distance: Int
        var x: Int
        var y: Int
        x = (p1.row - p2.row)*(p1.row - p2.row)
        y = (p1.col - p2.col)*(p1.col - p2.col)
        distance = Int(sqrt(Double(x+y)))
        return distance
    }
}





