//
//  TankWorldSupport.swift
//  TankLand
//
//  Created by Jennifer W. on 4/30/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
////
//
import Foundation

func isValidPosition(_ position: Position, numberRows: Int, numberCols: Int) -> Bool {
    return position.row < numberRows && position.row >= 0 && position.col < numberCols && position.col >= 0
}

func isPositionEmpty(_ positionEmpty: Position, grid: [[GameObject?]]) -> Bool {
    return grid[positionEmpty.row][positionEmpty.col] == nil
}

func isDead(_ gameObject: GameObject) -> Bool {
    return gameObject.energy <= 0
}

func getRandomInt(range: Int) -> Int{
    return Int(arc4random_uniform(UInt32(range)))
}

func findAllGameObjects(grid: [[GameObject?]], numberRows: Int, numberCols: Int) -> [GameObject] {
    var gameObjects = [GameObject]()
    for x in 0..<numberRows {
        for y in 0..<numberCols {
            if grid[x][y] != nil {
                let object = (grid[x][y])!
                gameObjects.append(object)
            }
        }
    }
    return gameObjects
}

func findAllTanks(grid: [[GameObject?]], numberRows: Int, numberCols: Int) -> [Tank] {
    var tanks = [Tank]()
    for x in 0..<numberRows {
        for y in 0..<numberCols {
            if let tank = grid[x][y] as? Tank {
                tanks.append(tank)
            }
        }
    }
    return tanks
}

func findAllRovers(grid: [[GameObject?]], numberRows: Int, numberCols: Int) -> [Mine] {
    var rovers = [Mine]()
    for x in 0..<numberRows {
        for y in 0..<numberCols {
            if grid[x][y]?.objectType == .Rover {
                if let rover = grid[x][y] as? Mine {
                    rovers.append(rover)
                }
            }
        }
    }
    return rovers
}

func getRandomDirection() -> Direction? {
    let randomNumber = getRandomInt(range: 8)
    switch randomNumber {
    case 0: return .North
    case 1: return .Northeast
    case 2: return .East
    case 3: return .Southeast
    case 4: return .South
    case 5: return .Southwest
    case 6: return .West
    case 7: return .Northwest
    default: return nil
    }
}

func isEnergyAvailable(_ gameObject: GameObject, amount: Int) -> Bool {
    return (gameObject.energy - amount) > 0
}

func adjacentPosition(_ position: Position) -> Position {
    let adjacentPositionCol = position.col + 1
    return Position(row: position.row, col: adjacentPositionCol)
}

func randomizeGameObjects<T: GameObject >(gameObjects: [T]) -> [T] {
    var arrayOfGO = gameObjects
    var randomized = [T]()
    for i in 0..<arrayOfGO.count {
        let random = Int(arc4random_uniform(UInt32(arrayOfGO.count)))
        randomized.append(arrayOfGO[random])
        arrayOfGO.remove(at: random)
    }
    return randomized
}

func numberOfLivingTanks(grid: [[GameObject?]], numberRows: Int, numberCols: Int) -> Int {
    var numberOfTanks = 0
    for x in 0..<numberRows {
        for y in 0..<numberCols {
            if grid[x][y] != nil {
                if grid[x][y]!.objectType == .Tank && grid[x][y]!.energy > 0 {
                    numberOfTanks += 1
                }
            }
        }
    }
    return numberOfTanks
}
