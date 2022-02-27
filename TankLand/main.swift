////
////  main.swift
////  TankLand
////
////  Created by Tracy Qiu on 4/9/18.
////  Copyright © 2018 Tracy Qiu. All rights reserved.
////



let numberOfCol = 15
let numberOfRow = 15
let cellSizeWidth = 7
let cellSizeLength = 4
let GO = GameObject(row: 2, col: 3, objectType: .Tank, energy: 10000, id: "J1")
let GO1 = GameObject(row: 4, col: 5, objectType: .Tank, energy: 4000, id: "bob")
var grid: [[GameObject?]]
grid = Array(repeating: Array(repeating: nil, count: numberOfCol), count: numberOfRow)
var tankWorld1 = TankWorld(numberRows: 15, numberCols: 15)
tankWorld1.addGameObject(gameObject: GO)
tankWorld1.addGameObject(gameObject: GO1)
printGrid(cellSizeWidth: cellSizeWidth, cellSizeLength: cellSizeLength, world: tankWorld1)





