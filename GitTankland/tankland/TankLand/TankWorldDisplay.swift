//
//  TankWorldDisplay.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

extension TankWorld{
    func renderType1(numberOfCol: Int, cellSizeWidth: Int) -> String{
        var type1 = ""
        var lengthOfType1 = (1 + cellSizeWidth)
        var totalWidth = numberOfCol * lengthOfType1 + 1
        while totalWidth != 0 {
            type1 += "_"
            totalWidth -= 1
        }
        type1 += "\n"
        return type1
    }
    
    func renderType2(numberOfCol: Int, cellSizeWidth: Int, currentRow: Int, gridArray: [[GameObject?]], lineIndex: Int) -> String {
        var type2 = ""
        for colIndex in 0..<numberOfCol {
            type2 += "|"
            var numberOfSpace = cellSizeWidth
            if gridArray[currentRow][colIndex] != nil && gridArray[currentRow][colIndex]?.objectType == .Tank {
                let cell = (gridArray[currentRow][colIndex])!
                if lineIndex == 0 {
                    type2.append("\(cell.id)")
                    numberOfSpace = cellSizeWidth - cell.id.count
                }
                if lineIndex == 1 {
                    type2.append("\(cell.energy)")
                    numberOfSpace = cellSizeWidth - "\(cell.energy)".count
                }
                if lineIndex == 2 {
                    let location = "(\(cell.position.row),\(cell.position.col))"
                    type2.append(location)
                    numberOfSpace = cellSizeWidth - location.count
                }
            }
            for x in 0..<numberOfSpace {
                type2 += " "
            }
        }
        type2 += "|"
        type2 += "\n"
        return type2
    }
    
    func renderType3(numberOfCol: Int, cellSizeWidth: Int) -> String {
        var type3 = ""
        for c in 0..<numberOfCol {
            type3 += "|"
            for x in 0..<cellSizeWidth {
                type3 += "_"
            }
        }
        type3 += "|"
        type3 += "\n"
        return type3
    }
    func renderRow(numberOfCol: Int, cellSizeWidth: Int, cellSizeLength: Int, gridArray: [[GameObject?]], currentRow: Int) -> String {
        var row = ""
        var lineIndex = 0
        while lineIndex != (cellSizeLength - 1) {
            row += renderType2(numberOfCol: numberOfCol, cellSizeWidth: cellSizeWidth, currentRow: currentRow, gridArray: gridArray, lineIndex: lineIndex)
            lineIndex += 1
        }
        row += renderType3(numberOfCol: numberOfCol, cellSizeWidth: cellSizeWidth)
        return row
    }
    
    func printGrid(cellSizeWidth: Int, cellSizeLength: Int) {
        var printGrid = ""
        printGrid += renderType1(numberOfCol: numberRows, cellSizeWidth: cellSizeWidth)
        for rowIndex in 0..<numberRows {
            printGrid += renderRow(numberOfCol: numberCols, cellSizeWidth: cellSizeWidth, cellSizeLength: cellSizeLength, gridArray: grid, currentRow: rowIndex)
        }
        print(printGrid)
    }
}





// type 1: _ * number of col * cell size + _@end
// type 2: number of col * (pipe + (space * (cell size - 1))) + pipe@end
// type 3: number of col * (pipe + (_ * (cell size - 1))) + pipe@end
