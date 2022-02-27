//
//  Array2DB.swift
//  GameofLife
//
//  Created by Tracy Qiu on 12/16/17.
//  Copyright © 2017 Tracy Qiu. All rights reserved.
//

import Cocoa
import Foundation

struct Array2DB{
    var values = [Int]()
    let numberRows: Int
    let numberCols: Int
    let rowsB: Int
    let colsB: Int
    init (numberRows:Int, numberCols: Int) {
        self.numberCols = numberCols
        self.numberRows = numberRows
        self.rowsB = numberRows + 2
        self.colsB = numberCols + 2
        values = [Int](repeating:0,count: rowsB * colsB)
    }
//    func get (_ row:Int, _ col:Int)-> Int {
//        return values[index(row,col)]
//    }
//    func set (_ row:Int, _ col:Int, _ value:Int){
//    }
    func index (_ row:Int, _ col:Int)-> Int{
        assert (row >= -1 && row <= numberRows, "row \(row) is out of bounds")
        assert (col >= -1 && col <= numberCols, "column \(col) is out of bounds")
        return (row + 1) * (colsB) + (col+1)
    }
    subscript (row: Int, col: Int) -> Int {
        get{
            return values[index(row, col)]
        }
        set (newValue){
            values[index(row, col)] = newValue
        }
    }
}




