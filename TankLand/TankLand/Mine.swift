//
//  Mine.swift
//  TankLand
//
//  Created by Tracy Qiu on 5/2/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

func getRandomInt(range: Int) -> Int{
    return Int(arc4random_uniform(UInt32(range)))
}

class Mine: GameObject{
    func explode(){
        
    func getRandomDirection() -> Direction? {
        let randomNumber = getRandomInt(range: 8)
        
        switch randomNumber {
        case 1: return .North
        case 2: return .Northeast
        case 3: return .East
        case 4: return .Southeast
        case 5: return .South
        case 6: return .Southwest
        case 7: return .West
        case 8: return .Northwest
        default: return nil
        }
    }
}
}
