//
//  Position.swift
//  TankLand
//
//  Created by Jennifer W. on 5/9/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

struct Position{
    var row: Int
    var col: Int
    
    init(row: Int, col: Int){
        self.row = row
        self.col = col
    }
    
    func Position() -> (Int, Int) {
        return (row, col)
    }
    
    func isSamePosition(_ otherPosition: Position) -> Bool {
        return otherPosition.row == row
            && otherPosition.col == col
    }
}

func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position {
    var p2Row = position.row
    var p2Col = position.col
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

func distance(_ p1: Position, _ p2: Position) -> Int {
    var distance: Int
    var x: Int
    var y: Int
    x = (p1.row - p2.row)*(p1.row - p2.row)
    y = (p1.col - p2.col)*(p1.col - p2.col)
    distance = Int(sqrt(Double(x+y)))
    return distance
}





