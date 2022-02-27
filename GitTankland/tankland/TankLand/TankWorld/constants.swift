//
//  constants.swift
//  TankLand
//
//  Created by Jennifer W. on 5/2/18.
//  Copyright © 2018 Jennifer W. All rights reserved.
//

import Foundation

struct Constants {
    static let costOfReleasingMine = 200
    var initialTankEnergy = 10000
    var costOfRadarByUnitsDistance = [0, 100, 200, 400, 800, 1600, 3200, 6400, 12400]
    var costOfSendingMessage = 100
    var costOfReceivingMessage = 100
    var costOfReleasingRover = 500
    var costOfLaunchingMissile = 1000
    var costOfFlyingMissilePerUnitDistance = 200
    var costOfMovingTankPerUnitDistance = [100, 300, 600]
    var costOfMovingRover = 50
    var costLifeSupportTank = 100
    var costLifeSupportRover = 40
    var costLifeSupportMine = 20
    let missileStrikeMultiple = 10
    var missileStrikeMultipleCollateral = 3
    var mineStrikeMultiple = 5
    var shieldPowerMultiple = 8
    var missileStrikeEnergyTransferFranction = 4
}

