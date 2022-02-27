//
//  TTuple.swift
//  Turing
//
//  Created by Tracy Qiu on 2/21/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

enum Direction {
    case l
    case r
}

struct TTuple: CustomStringConvertible {
    let currentState: Int
    let inputChar: Character
    let newState: Int
    let outputChar: Character
    let direction: Direction
    init(currentState: Int, inputChar: Character, newState: Int, outputChar: Character, direction: Direction){
        self.currentState = currentState
        self.inputChar = inputChar
        self.newState = newState
        self.outputChar = outputChar
        self.direction = direction
    }

    static func makeKey(_ state: Int, _ inputChar: Character)-> String{
        return "\(state) \(inputChar)"
    }
    func getKey()-> String{
        return "\(currentState) \(inputChar)"
    }

    var description: String{
        return "cs:\(currentState) ic:\(inputChar) ns:\(newState) oc:\(outputChar) di:\(direction)"
    }
    func nakedTuple()-> String{
        return "\(currentState)  \(inputChar)  \(newState)  \(outputChar)  \(direction)"
    }
}


