////
////  Logger.swift
////  TankLand
////
////  Created by Tracy Qiu on 6/7/18.
////  Copyright © 2018 Jennifer W. All rights reserved.
////
//
import Foundation

class Logger: CustomStringConvertible {
    var turnNum: Int
    var numberOfTanks: Int
    var actionDesc: String
    var addedTanks: String
    
    init(turnNum: Int) {
        self.turnNum = turnNum
        self.numberOfTanks = 0
        self.actionDesc = ""
        self.addedTanks = ""
    }
    
    func getCurrentTimeStampWOMilliseconds() -> String {
        let currentDateTime = Date()
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "HH:mm:ss"
        return objDateformat.string(from: currentDateTime)
    }
    
    func addMajorLog(_ gameObject: GameObject, _ desc: String) {
        var log = ""
        log += "\(turnNum) "
        log += "\(getCurrentTimeStampWOMilliseconds()) "
        log += "\(gameObject.id) \(gameObject.position.Position()) \(desc) "
        self.addedTanks += "\(log) \n"
    }
    
    func addLog(_ gameObject: GameObject, _ desc: String) {
        var log = ""
        log += "\(turnNum) "
        log += "\(getCurrentTimeStampWOMilliseconds()) "
        log += "\(gameObject.id) \(gameObject.position.Position()) \(desc) "
        self.actionDesc += "\(log) \n"
    }
    var description: String {
        var desc = ""
        desc += "\(addedTanks) \n"
        if actionDesc != "" {
            desc += "Beginning Turn #\(turnNum) \n"
            desc += "NLT: \(numberOfTanks) \n"
            desc += "\(actionDesc) \n"
        }
        return desc
    }
    
}

