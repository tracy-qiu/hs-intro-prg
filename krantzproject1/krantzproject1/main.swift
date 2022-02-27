
//  main.swift
//  krantzproject1
//
//  Created by Tracy Qiu on 12/12/17.
//  Copyright © 2017 Tracy Qiu. All rights reserved.


import Foundation

let test1 = Stats(values: [2.0,3.0,4.0,5.0,6.0])
print ("sum: \(test1.sum())")
print ("mean: \(test1.mean())")
print ("median: \(test1.median())")
print ("standard deviation: \(test1.stdev())")
print ("primes: \(test1.primes())")

var test = " "
test += "add one 10 17 29 3 59 32\n"
test += "add two 3.0 11.0 3.0 6.0 8.0\n"
test += "add three 24 65 71 28 11\n"
test += "info\n"
test += "sum\n"
test += "mean\n"
test += "median\n"
test += "stdev\n"
test += "primes\n"
test += "five\n"
test += "current two\n"
test += "info\n"
test += "sum\n"
test += "mean\n"
test += "median\n"
test += "stdev\n"
test += "primes\n"
test += "five\n"
test += "quit\n"
var testing = StatsVC()
testing.setConsoleText(_text:test)
testing.runStats()






