//
//  Logger.swift
//  TankLand
//
//  Created by Tracy Qiu on 5/9/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

struct Logger: CustomStringConvertible {
    var id: String
    var energy: Int
    var position: Position
    var GameObject: GameObject
    var turnNum: Int
    var action: Action
//    var timeStamp
    
    var description: String {
        var desc = ""
        desc += "Beginning Turn #\(turnNum)"
        desc += "NLT"
        for i in Actions {
            
            print "\(turnNum) timeStamp \(id) \(Position) \(Action) "
        }
    }
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
}
