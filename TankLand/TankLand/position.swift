//
//  position.swift
//  TankLand
//
//  Created by Tracy Qiu on 5/2/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

enum Direction {
    case North, Northeast, East, Southeast, South, Southwest, West, Northwest
}

struct Position{
    var row: Int
    var col: Int
    var grid: [[GameObject?]]
    var direction: Direction

    init(row: Int, col: Int){
        self.row = row
        self.col = col
    }

    func Position() -> (Int, Int) {
        return (row, col)
    }

}

func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position {
    var p2Row: Int
    var p2Col: Int
    switch direction {
    case .North: p2Row += magnitude
    case .Northeast: p2Row -= magnitude ; p2Col += magnitude
    case .East: p2Col += magnitude
    case .Southeast: p2Row += magnitude ; p2Col += magnitude
    case .South: p2Row -= magnitude
    case .Southwest: p2Row += magnitude ; p2Col -= magnitude
    case .West: p2Col -= magnitude
    default: return Position(row: p2Row, col: p2Col)
    }
    return Position(row: p2Row, col: p2Col)
}

func isValidPosition(_ position: Position) -> Bool {
    var position: Position
    return 0 <= position.row <= 15 && 0 <= position.col <= 15
}

func isPositionEmpty(_ positionEmpty: Position) -> Bool {
    let position: Position 
    return GameObject(row: <#T##Int#>, col: <#T##Int#>, objectType: <#T##GameObjectType#>, name: <#T##String#>, energy: <#T##Int#>, id: <#T##String#>)
    
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
func isGoodIndex(row: Int, col: Int) -> Bool {
    var position: Position
    return 0 >= position.row >= 15 && 0 >= position.col >= 15
}


