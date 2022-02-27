//
//  StatsVC.swift
//  krantzproject1
//
//  Created by Tracy Qiu on 12/12/17.
//  Copyright © 2017 Tracy Qiu. All rights reserved.
//

import Cocoa

struct StatsVC: CustomStringConvertible {
    var data = [String : Stats]()
    var name: String?
    var command: String
    var numberData = [Double]()
    init () {
        self.name = nil
        self.command = " "
        self.numberData = [Double]()
    }
    func splitStringIntoParts(_expression: String)->[String]{
        return _expression.split {$0 == " "}.map{ String($0)}
    }
    func splitStringIntoLines(_expression: String)->[String]{
        return _expression.split {$0 == "\n"}.map{ String($0)}
    }
    var files = [String : String]()
    var consoleData = [String]()
    var consoleLineIndex = 0
    mutating func writeTextFile(name: String, text: String) {
        files[name] = text
    }
    func readTextFile(name: String)->String?{
        return files[name]
    }
    mutating func setConsoleText (_text: String){
        consoleData = splitStringIntoLines(_expression:_text)
        consoleLineIndex = 0
    }
    mutating func getLineFromConsole()-> String? {
        if consoleLineIndex == consoleData.count{
            return nil
        } else {
            consoleLineIndex += 1
            print (consoleData[consoleLineIndex - 1])
            return consoleData[ consoleLineIndex - 1]
        }
    }
    var description: String{
        var description = String()
        for (n, v) in data {
            if n == name {
                description += "*\(n) \(v.values)\n"
            } else {
                description += "\(n) \(v.values)\n"
            }
        }
        return description
    }
    mutating func addData(input: [String]){
        var userInput = input
        name = userInput[0]
        var numberData = [Double]()
        for i in 1..<userInput.count{
            numberData.append (Double(userInput[i])!)
        }
        data.updateValue(Stats(values: numberData), forKey: name!)
    }
    mutating func executeCommand(command: String, commandParts:[String])->String?{
        switch command {
        case "add": addData(input:commandParts)
        return nil
        case "current": name = commandParts[0]
        return nil
        case "sum": return "Sum is \((data[name!]!).sum())"
        case "mean": return "Mean is \((data[name!]!).mean())"
        case "median": return "Median is \((data[name!]!).median())"
        case "stdev": return "Standard Deviation is \((data[name!]!).stdev())"
        case "primes": return "Primes are \((data[name!]!).primes())"
        case "five": return "Five number summary is \((data[name!]!).five())"
        case "help": var help = "Stats Commands:\n"
        help += "current name - set the current stats data set to name\n"
        help += "sum - sum of current data set\n"
        help += "mean - mean of current data set\n"
        help += "median - median of current data set\n"
        help += "stdev - standard deviation of current data set\n"
        help += "primes - prime numbers in a current data set\n"
        help += "five number summary of the current data set"
        help += "write fileName - write the stats database to file fileName\n"
        help += "read fileName - read the stats database from file fileName\n"
        help += "help - this help message\n"
        help += "info - info report\n"
        help += "quit - quit stats\n"
        return help
        case "info": return description
        case "quit": return nil
        default : return "Bad command"
        }
    }
    mutating func runStats() {
        print ("Welcome to Stats")
        print ("Command... ", terminator:"")
        data ["default"] = Stats(values:[1.0,2.0,3.0,4.0,5.0])
        var commandLine = getLineFromConsole()
        var commandParts = splitStringIntoParts(_expression:commandLine!)
        command = commandParts.remove (at:0)
        while commandLine != nil && command != "quit" {
            let commandExecution = executeCommand(command: command, commandParts: commandParts)
            if commandExecution != nil{
                print (commandExecution!)
            }
            print ("Command... ", terminator:"")
            commandLine = getLineFromConsole()
            if commandLine != nil{
                commandParts = splitStringIntoParts(_expression:commandLine!)
                command = commandParts.remove (at:0)
            }
        }
    }
}




