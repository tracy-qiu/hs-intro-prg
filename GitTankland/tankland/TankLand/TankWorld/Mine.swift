//
//  Mine.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//
//
import Foundation

class Mine: GameObject{
    func explode() {
        die()
    }
}

    
//    init(row: Int, col: Int, energy: Int, id: String) {
//        super.init(row: row, col: col, objectType: .Mine, energy: energy, id: id)
//    }
//
//    func explode() {
//        energy == 0
//    }
//}
