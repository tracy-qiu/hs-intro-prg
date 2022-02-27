//
//  employee.swift
//  Employees
//
//  Created by Tracy Qiu on 1/30/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

enum EmployeeType {
    case Employee, Salaried, Hourly, Manager, Executive
}
class Employee: CustomStringConvertible {
    private static var nextEmployeeNumber = 1
    let firstName: String
    let lastName: String
    let employeeNumber: Int
    var employeeType: EmployeeType
    var yearsEmployed: Int
    
    func weeklySalary() -> Int{
        fatalError("It is illegal to make an Employee object")
    }
    
    func newYear(){
        yearsEmployed += 1
    }
    func raise(amount: Int){
    }
    
    init(lastName:String, firstName: String, yearsEmployed: Int, employeeType: EmployeeType){
        self.lastName = lastName
        self.firstName = firstName
        employeeNumber = Employee.nextEmployeeNumber
        Employee.nextEmployeeNumber += 1
        self.yearsEmployed = yearsEmployed
        self.employeeType = employeeType
    }
    
    var description: String{
        var desc = ""
        desc += "\(lastName), \(firstName)\n"
        desc += " Employee Type: \(employeeType)\n"
        desc += " Employee Number: \(employeeNumber)\n"
        desc += " Years Employed: \(yearsEmployed)\n"
        desc += " Weekly Salary: \(weeklySalary())\n"
        return desc
    }
}

class HourlyEmployee: Employee{
    var basicHourlyRate: Int
    var regularHours: Int
    var holidayHours: Int
    
    init(lastName: String, firstName: String, basicHourlyRate: Int) {
        self.basicHourlyRate = basicHourlyRate
        self.regularHours = 0
        self.holidayHours = 0
        super.init(lastName: lastName, firstName: firstName, yearsEmployed: 0, employeeType: .Hourly)
    }
    
    override func weeklySalary() -> Int {
        var holidayPay = 0
        holidayPay = 2 * holidayHours * basicHourlyRate
        var overForty: Int
        overForty = basicHourlyRate * 40
        var overEighty: Int
        overEighty = Int(1.5 * Double(basicHourlyRate * 40))
        switch regularHours {
            case 0...40: return (basicHourlyRate * regularHours) + holidayPay
            case 41...80: return overForty + Int(1.5 * Double(basicHourlyRate) * Double(regularHours - 40)) + holidayPay
            case 81...168: return overForty + overEighty + (2 * basicHourlyRate * (regularHours - 80)) + holidayPay
            default: return holidayPay
        }
    }
    override func raise(amount: Int) {
        basicHourlyRate += amount
    }
    func workHours(hours:Int){
        regularHours += hours
    }
    func workDoubleTimeHours(hours: Int) {
        holidayHours += hours
    }
    func newWeek() {
        regularHours = 0
        holidayHours = 0
    }
    override var description: String{
        return super .description + " Hourly Rate: \(basicHourlyRate)\n Regular Hours: \(regularHours)\n Holiday Hours: \(holidayHours)\n"
    }
}

class SalariedEmployee: Employee {
    var annualSalary: Int
    
    init (lastName: String, firstName: String, annualSalary: Int){
        self.annualSalary = annualSalary
        super.init(lastName:lastName, firstName: firstName, yearsEmployed: 0, employeeType: .Salaried)
    }
    
    override func raise(amount: Int) {self.annualSalary += amount}
    
    override func weeklySalary() -> Int {return annualSalary/52}
    
    override var description: String{
        return super .description + " Annual salary: \(annualSalary)\n"
    }
}

class ManagerEmployee: SalariedEmployee {
    var initialManagerRating: Int
    var annualBonus: Int
    
    init(lastName: String, firstName: String, annualSalary: Int, initalManagerRating: Int) {
        self.initialManagerRating = initalManagerRating
        self.annualBonus = 0
        super.init(lastName: lastName, firstName: firstName, annualSalary: annualSalary)
        self.employeeType = .Manager
    }
    func setManagerRating(newRating: Int) { initialManagerRating = newRating}
    
    override func weeklySalary() -> Int {
        annualBonus = Int(0.1 * Double(initialManagerRating * annualSalary))
        return (annualSalary + annualBonus)/52
    }
    override var description: String {
        return super .description + " Annual Bonus: \(annualBonus)\n Manager Rating: \(initialManagerRating)\n"
    }
}

class ExecutiveManager: ManagerEmployee{
    var additionalBonus: Int
    private static var nextExecutive = 1
    var numberExecutives: Int

    override init(lastName: String, firstName: String, annualSalary: Int, initalManagerRating: Int){
        self.additionalBonus = 0
        numberExecutives = ExecutiveManager.nextExecutive
        ExecutiveManager.nextExecutive += 1
        super.init(lastName: lastName, firstName: firstName, annualSalary: annualSalary, initalManagerRating: initalManagerRating)
        self.employeeType = .Executive
    }
    
    func setAnnualProfit(_ annualProfit: Int) {
        additionalBonus = Int(0.1 * Double(annualProfit))/numberExecutives
    }
    
    override func weeklySalary() -> Int {
        annualBonus = Int(0.1 * Double(initialManagerRating * annualSalary))
        return (annualSalary + annualBonus + additionalBonus)/52
    }
    
    override var description: String {
        return super .description + " Additional Bonus: \(additionalBonus)\n Number Of Executives: \(numberExecutives)\n"
    }
}







