//
//  TuringSupport.swift
//  Turing
//
//  Created by Tracy Qiu on 2/21/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

//Helper Functions
func splitStringIntoParts(expression: String)-> [String]{
    return expression.split{$0 == " "}.map {String($0)}
}

func splitStringIntoLines(expression: String)-> [String] {
    return expression.split{$0 == "\n"}.map {String($0)}
}

//Functions to perform actual i/o from filesystem
func readTextFile(_ path: String)-> (message:String?, fileText: String?) {
    let text: String
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    }
    catch {
        return ("\(error)", nil)
    }
    return (nil, text)
}

func readTuples (tuplesAsString: String) -> [TTuple] {
    var ttuples = [TTuple]()
    let tuplesStringArray = splitStringIntoLines(expression: tuplesAsString)
    for t in tuplesStringArray {ttuples.append(makeTTupleFromString(t))}
    return ttuples
}

private func makeTTupleFromString(_ data: String)-> TTuple{
    var direction: Direction
    let elements = splitStringIntoParts(expression: data)
    
    let currentState = Int(elements[0])!
    let newState = Int(elements[2])!
    let inputChar = elements[1].first!
    let outputChar = elements[3].first!
    let directionAsChar = elements[4]
    
    direction = (directionAsChar == "1") || (directionAsChar == "l") ? .l : .r
    return TTuple(currentState: currentState, inputChar: inputChar, newState: newState, outputChar: outputChar, direction: direction)
}
