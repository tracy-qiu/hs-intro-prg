//
//  TuringVM.swift
//  Turing
//
//  Created by Tracy Qiu on 2/21/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

class TuringVM {
    var ttuplesArray: [TTuple]
    var ttupleDictionary: [String: TTuple]
    
    func tupleReport()-> String{
        var report = ""
        for t in ttuplesArray{
            report += "\(t)\n"
        }
        return report
    }
    func nakedTupleReport()-> String{
        var naked = "cs ic ns oc di\n"
        for t in ttuplesArray{
            naked += "\(t.nakedTuple())\n"
        }
        return naked
    }
    
    init (ttuplesArray: [TTuple]){
        self.ttuplesArray = ttuplesArray
        self.ttupleDictionary = [String: TTuple]()
        for t in ttuplesArray {self.ttupleDictionary[t.getKey()] = t}
    }
    
    var numberTuples: Int {
        var total = 0
        for _ in ttuplesArray{
            total += 1
        }
        return total
    }
    func tapeAsString()-> String{
        return String(describing: ttuplesArray)
    }
    
    func findTuple(_ cs: Int, _ ic: Character)-> TTuple? {
        let key = TTuple.makeKey(cs, ic)
        return ttupleDictionary[key]
    }
    
    func finishedRunning(_ index: Int, _ initialTape: [Character]) -> Bool {
        return index < 0 || index >= initialTape.count
    }
    
    func runTuring(initialTape: String, initialState: Int, initialHead: Int)-> (numberSteps: Int, finalTape: String, trace: [String]){
        var tape = Array(initialTape)
        var index = initialHead
        var character: Character
        var cs = initialState
        var numberSteps = 0
        var finalTape = tape
        var trace = [""]
        
        while finishedRunning(index, tape) == false {
            character = tape[index]
            if let t = findTuple(cs, character) {
                let mutableIndex = index
                if t.direction == Direction.r{
                    index += 1
                } else {
                    index -= 1
                }
                cs = t.newState
                numberSteps += 1
                
                finalTape[mutableIndex] = t.outputChar
                tape = finalTape
                var traceTape = finalTape
                character = traceTape[index]
                traceTape.insert("[", at: index)
                traceTape.insert("]", at: index + 2)
                trace.append("\(numberSteps): {\(t)} \(String(traceTape))")
            } else {
                break
            }
        }
        return (numberSteps, String(finalTape), trace)
    }
}
