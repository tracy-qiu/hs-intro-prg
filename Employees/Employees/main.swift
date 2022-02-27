//
//  main.swift
//  Employees
//
//  Created by Tracy Qiu on 1/30/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

var employees = [Employee]()
var s = SalariedEmployee(lastName: "Jones", firstName: "Fred", annualSalary: 35000)
s.raise(amount: 10000)
employees.append(s)

var h = HourlyEmployee(lastName: "Smith", firstName: "Phil", basicHourlyRate: 22)
h.raise(amount: 3)
h.workHours(hours: 10)
h.workHours(hours: 40)
h.workHours(hours: 35)
h.workDoubleTimeHours(hours: 20)
employees.append(h)

var m = ManagerEmployee(lastName: "Talbot", firstName: "Henry", annualSalary: 65000, initalManagerRating: 3)
m.raise(amount: 10000)
m.setManagerRating(newRating: 4)
employees.append(m)

var x = ExecutiveManager(lastName: "Strong", firstName: "Sue", annualSalary: 125000, initalManagerRating: 3)
employees.append(x)
var x2 = ExecutiveManager(lastName: "Bran", firstName: "Ted", annualSalary: 120000, initalManagerRating: 4)
employees.append(x2)
var x3 = ExecutiveManager(lastName: "White", firstName: "Ann", annualSalary: 175000, initalManagerRating: 2)
employees.append(x3)
x3.setAnnualProfit(2000000)

for e in employees { print (e,"\n")}

print ("\n\nWeekly Payroll Check Run:\n")
for e in employees {
    print ("\(e.lastName), \(e.firstName)")
    print ("  Check Amount: \(e.weeklySalary())\n")
}

//var t1 = SalariedEmployee(lastName: "Smith", firstName: "Fred", annualSalary: 52000)
//print (t1)
//
//var t2 = HourlyEmployee(lastName: "Parker", firstName: "Sam", basicHourlyRate: 10)
//t2.workHours(hours: 1)
//t2.workHours(hours: 5)
//t2.workDoubleTimeHours(hours: 2)
//t2.newYear()
//print (t2)
//t2.newWeek()
//t2.workHours(hours: 4)
//print (t2)



