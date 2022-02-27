//
//  Stats.swift
//  krantzproject1
//
//  Created by Tracy Qiu on 12/12/17.
//  Copyright © 2017 Tracy Qiu. All rights reserved.
//

import Cocoa
import Foundation

struct Stats: CustomStringConvertible{
    let values: [Double]
    init (values: [Double]){
        self.values = values
    }
    
    func sum() -> Double {
        var sumValues = 0.0
        for i in values{
            sumValues += i
        }
        return sumValues
    }
    
    func mean() -> Double {
        return sum()/Double(values.count)
    }
    
    func median() -> Double {
        let sortedValues = values.sorted
        if sortedValues().count % 2 == 1 {
            let i = Int((sortedValues().count)/2)
            return sortedValues()[i]
        }else {
            let i = Int((sortedValues().count)/2)
            return (sortedValues()[i] + sortedValues()[i-1])/2
        }
    }
    
    func stdev() -> Double {
        let meanValues = sum()/Double(values.count)
        var numerator = 0.0
        for i in values {
            numerator += (i - meanValues) * (i - meanValues)
        }
        let denominator = Double(values.count - 1)
        var stdevValues = 0.0
        stdevValues = sqrt(numerator/denominator)
        return stdevValues
    }
    
    func isPrime(number:Int) -> Bool {
        if number < 1{
            return false
        }
        if number >= 4{
            let x = Int(sqrt(Double(number)))
            for i in 2...x {
                if number % i == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    func primes() ->[Int]{
        var numberSet = Set<Int>()
        for v in values{
            numberSet.insert(Int(v))
        }
        var primeNumbers = [Int]()
        for i in numberSet{
            if isPrime(number: i) == true {
                primeNumbers.append(i)
            }
        }
        return primeNumbers
    }
    
    func five()->(smallest: Double, q1:Double, median:Double, q3:Double, largest: Double){
        let sortedValues = values.sorted()
        let smallest = sortedValues[0]
        let largest = sortedValues[values.count-1]
        var firstHalf = [Double]()
        for f in 0..<(sortedValues.count/2){
            firstHalf.append(sortedValues[f])
        }
        let firstarray = Stats(values: firstHalf)
        let q1 = firstarray.median()
        var secondHalf = [Double]()
        if sortedValues.count % 2 != 0{
            for s in ((sortedValues.count/2)+1)..<sortedValues.count{
                secondHalf.append(sortedValues[s])
            }
        }else{
            for s in ((sortedValues.count/2))..<sortedValues.count{
                secondHalf.append(sortedValues[s])
            }
        }
        let secondArray = Stats(values: secondHalf)
        let q3 = secondArray.median()
        return (smallest: smallest, q1: q1, median: median(), q3: q3, largest: largest)
    }
    var description: String{
        return "(The five number summary is \(five()))"
    }
}




