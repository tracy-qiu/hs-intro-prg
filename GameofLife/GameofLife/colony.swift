//
//  colony.swift
//  GameofLife
//
//  Created by Tracy Qiu on 12/30/17.
//  Copyright © 2017 Tracy Qiu. All rights reserved.
//

import Cocoa

struct Colony: CustomStringConvertible{
    var colonySize: Int
    var data: Array2DB
//    var surroundingAlive: Int
    var generation: Int
    var data2 : Array2DB
    init(colonySize: Int){
        self.colonySize = colonySize
        self.data = Array2DB(numberRows:colonySize, numberCols:colonySize)
//        self.surroundingAlive = Int()
        self.generation = Int()
        self.data2 = Array2DB(numberRows:colonySize, numberCols:colonySize)
    }
    
    mutating func setCellAlive(rCoor: Int, cCoor: Int){
        data[rCoor,cCoor] = 1
    }
    mutating func setCellDead(rCoor: Int, cCoor: Int){
        data[rCoor,cCoor] = 0
    }
    mutating func resetColony() {
        for r in 0..<colonySize{
            for c in 0..<colonySize{
                data[c,r] = 0
            }
        }
    }
    var description: String{
        var description = ""
        description += "Generation #\(generation)\n"
        for r in 0..<colonySize{
            for c in 0..<colonySize{
                if isCellAlive(rCoor: r, cCoor: c) == true {
                    description += "*"
                }else {
                    description += "."
                }
            }
            description += "\n"
        }
        return description
    }
    
    func isCellAlive(rCoor: Int, cCoor: Int)-> Bool{
        if data[rCoor,cCoor] == 1 {
            return true
        }else {
            return false
        }
    }
    
    var numberLivingCells: Int{
        var numberLivingCells = 0
        for r in 0..<colonySize{
            for c in 0..<colonySize{
                if isCellAlive(rCoor: r, cCoor: c) == true {
                    numberLivingCells += 1
                }
            }
        }
        return numberLivingCells
    }
    

//    func surroundingCells(rCoor:Int, cCoor: Int)-> Int {
//        var surroundingAlive = 0
////        var surrounding = Array2DB(numberRows:colonySize, numberCols:colonySize)
////        surrounding += data[rCoor-1, cCoor-1]
////        surrounding += data[rCoor-1, cCoor]
////        surrounding += data[rCoor-1, cCoor+1]
////        surrounding += data[rCoor, cCoor-1]
////        surrounding += data[rCoor, cCoor+1]
////        surrounding += data[rCoor+1, cCoor-1]
////        surrounding += data[rCoor+1, cCoor]
////        surrounding += data[rCoor+1, cCoor+1]
//        for r in rCoor-1...rCoor+1{
//            for c in cCoor-1...cCoor+1{
//                while [r,c] != [rCoor,cCoor]{
//                    if data[r,c] == 1 {
//                        surroundingAlive += 1
//                    }
//                }
//            }
//        }
//        return surroundingAlive
//    }
    
    func surroundingCells(rCoor:Int, cCoor: Int)-> Int {
//        var surrounding: [Array2DB, Array2DB]
        var surroundingAlive = 0
        if data[rCoor-1, cCoor-1] == 1{
            surroundingAlive += 1
        }
        if data[rCoor-1, cCoor] == 1 {
            surroundingAlive += 1
        }
        if data[rCoor-1, cCoor+1] == 1{
            surroundingAlive += 1
        }
        if data[rCoor, cCoor-1] == 1{
            surroundingAlive += 1
        }
        if data[rCoor, cCoor+1] == 1{
            surroundingAlive += 1
        }
        if data[rCoor+1, cCoor-1] == 1{
            surroundingAlive += 1
        }
        if data[rCoor+1, cCoor] == 1{
            surroundingAlive += 1
        }
        if data[rCoor+1, cCoor+1] == 1{
            surroundingAlive += 1
        }
//                var surrounding = [Array2DB(numberRows:colonySize, numberCols:colonySize)]
//                surrounding += data[rCoor-1, cCoor-1]
//                surrounding += data[rCoor-1, cCoor]
//                surrounding += data[rCoor-1, cCoor+1]
//                surrounding += data[rCoor, cCoor-1]
//                surrounding += data[rCoor, cCoor+1]
//                surrounding += data[rCoor+1, cCoor-1]
//                surrounding += data[rCoor+1, cCoor]
//                surrounding += data[rCoor+1, cCoor+1]
//        for r in rCoor-1...rCoor+1{
//            for c in cCoor-1...cCoor+1{
////                while r != rCoor && c != cCoor{
////                if [r,c] != [rCoor,cCoor]{
//                if data[r,c] == 1 {
//                    surroundingAlive += 1
//        var surroundingAlive = 0
//        for r in rCoor-1...rCoor+1{
//            for c in cCoor-1 {
//
//            }
//        }
//            }
//        }
        return surroundingAlive
    }
    
    mutating func rules(r:Int, c: Int) {
        if isCellAlive(rCoor: r, cCoor: c) == true{
            if surroundingCells(rCoor: r, cCoor: c) < 2 || surroundingCells(rCoor: r, cCoor: c) > 3 {
//                setCellDead(rCoor: r, cCoor: c)
                data2[r,c] = 0
            }else{
               data2[r,c] = 1
            }
        }else{
            if surroundingCells(rCoor: r, cCoor: c) == 3{
//               setCellAlive(rCoor: r, cCoor: c)
                data2[r,c] = 1
            }else{
                data2[r,c] = 0
            }
        }
    }
    mutating func evolve() {
//        generation = 0
//        var data2 = Array2DB(numberRows:colonySize, numberCols:colonySize)
        for r in 0..<colonySize{
            for c in 0..<colonySize{
////                if data[r,c] == 1 {
//                if isCellAlive(rCoor: r, cCoor: c) == true{
//                    if surroundingCells(rCoor: r, cCoor: c) < 2 || surroundingCells(rCoor: r, cCoor: c) > 3 {
////                        setCellDead(rCoor: r, cCoor: c)
//                        data2[r,c] = 0
//                    }else{
//                        data2[r,c] = 1
//                    }
//                } else {
//                    if surroundingCells(rCoor: r, cCoor: c) == 3{
////                        setCellAlive(rCoor: r, cCoor: c)
//                        data2[r,c] = 1
//                    }else{
//                        data2[r,c] = 0
//                    }
//                }
                rules(r: r, c: c)
//                if isCellAlive(rCoor: r, cCoor: c) == true {
//                    data2[r,c] = 1
//                }else{
//                    data2[r,c] = 0
//                }
            }
        }
        data = data2
//        generation += 1
    }

    
    func splitStringIntoParts(_expression: String)->[String]{
        return _expression.split {$0 == " "}.map{ String($0)}
    }
    mutating func userInterface() {
        print("Colony Size...", terminator: "")
        let colonyCommand = readLine()
        colonySize = Int(colonyCommand!)!
        print("Enter x y coordinates of living cells, blank line when done")
        print("Coor: ", terminator: "")
        var commandLine = readLine()!
        while commandLine != "" {
            var commandParts = splitStringIntoParts(_expression: commandLine)
            let r = Int(commandParts[0])!
            let c = Int(commandParts[1])!
            setCellAlive(rCoor: r, cCoor: c)
            print("Coor: ", terminator: "")
            commandLine = readLine()!
        }
        print("Running evolution.")
        print("Commands are:")
        print("Enter an Int, evolve that number generation")
        print("Q, quit")
        print("Any other text evolve one generation")
        generation = 0
//        print("Generation #\(generation)")
        print(description)
        print("Command...", terminator: "")
        commandLine = readLine()!
        generation += 1
        while commandLine != "" {
            while commandLine != "Q" && commandLine != "q" && Int(commandLine) == nil {
//                print("Generation #\(generation)")
                evolve()
                print(description)
                print("Command...", terminator: "")
                commandLine = readLine()!
                generation += 1
            }
            var currentGen = 1
            while Int(commandLine) != nil {
                let evolveNum = Int(commandLine)!
                while currentGen <= evolveNum {
//                    print("Generation #\(generation)")
                    evolve()
                    print(description)
                    generation += 1
                    currentGen += 1
                }
                print("Command...", terminator: "")
                commandLine = readLine()!
                currentGen = 1
            }
            if commandLine == "Q" {
                exit(0)
            }
            if commandLine == "q" {
                exit(0)
            }
        }
    }
}
