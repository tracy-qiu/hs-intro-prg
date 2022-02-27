//
//  main.swift
//  Turing
//
//  Created by Tracy Qiu on 2/21/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

func simpleTuringRun() {
    var tupleString = "0 _ 0 _ r\n"
    tupleString += "0 0 1 1 r\n"
    tupleString += "0 1 1 0 r\n"
    tupleString += "1 1 1 0 r\n"
    tupleString += "1 0 1 1 r\n"

    let tuplesArray = readTuples(tuplesAsString: tupleString)
    let tvm = TuringVM(ttuplesArray: tuplesArray)
    let result = tvm.runTuring(initialTape: "_111000_", initialState: 0, initialHead: 0)
    print ("Tuples:")
    print (tvm.nakedTupleReport())
    print ("Initial String: \"_111000_\" Initial State: 0 Initial Head Position: 0")
    print ("\n*Running Turing*\n")
    print ("Number Steps In Run: \(result.numberSteps)")
    print ("Final Tape: \(result.finalTape)")
    print ("\nTrace:")
    for line in result.trace{print("" + line)}
}
simpleTuringRun()

func simpleTuringRun3() {
    var tupleString = ""
    tupleString += "0 - 0 - r\n"
    tupleString += "0 1 2 x r\n"
    tupleString += "2 1 2 1 r\n"
    tupleString += "2 - 3 - r\n"
    tupleString += "3 1 3 1 r\n"
    tupleString += "3 - 4 1 l\n"
    tupleString += "4 1 4 1 l\n"
    tupleString += "4 - 5 - l\n"
    tupleString += "5 1 6 1 l\n"
    tupleString += "5 x 7 1 l\n"
    tupleString += "7 x 7 1 l\n"
    tupleString += "6 1 6 1 l\n"
    tupleString += "6 x 0 x r\n"

    let tuplesArray = readTuples(tuplesAsString: tupleString)
    let tvm = TuringVM(ttuplesArray: tuplesArray)
    let result = tvm.runTuring(initialTape: "-111----------", initialState: 0, initialHead: 0)
    print ("Tuples:")
    print (tvm.nakedTupleReport())
    print ("Initial String: \"-111----------\" Initial State: 0 Initial Head Position: 0")
    print ("\n*Running Turing*\n")
    print ("Number Steps In Run: \(result.numberSteps)")
    print ("Final Tape: \(result.finalTape)")
    print ("\nTrace:")
    for line in result.trace{print("" + line)}
}
simpleTuringRun3()

func simpleTuringRun2() {
    var tupleString = "0 _ 0 _ r\n"
    tupleString += "0 X 0 A r\n"
    tupleString += "0 . 0 . r\n"
    tupleString += "0 Y 0 B r\n"
    tupleString += "0 + 1 + l\n"
    tupleString += "1 B 1 D l\n"
    tupleString += "1 . 1 . l\n"
    tupleString += "1 A 1 C l\n"

    let tuplesArray = readTuples(tuplesAsString: tupleString)
    let tvm = TuringVM(ttuplesArray: tuplesArray)
    let result = tvm.runTuring(initialTape: "_XX.YYY+", initialState: 0, initialHead: 0)
    print ("Tuples:")
    print (tvm.nakedTupleReport())
    print ("Initial String: \"_XX.YYY+\" Initial State: 0 Initial Head Position: 0")
    print ("\n*Running Turing*\n")
    print ("Number Steps In Run: \(result.numberSteps)")
    print ("Final Tape: \(result.finalTape)")
    print ("\nTrace:")
    for line in result.trace{print("" + line)}
}
simpleTuringRun2()




//
//let a = 12
//let z = (a == 12) ? 5 : 45
//print (z)
//
//func even (n:Int) -> Bool{
//    return n % 2 == 0
//}
//for n in 0..<20 where even (n:n){
//    print (n)
//}
//
//var n: Int?
//n = nil
//if let k = n {
//    print ("n had a value")
//}else{
//    print ("n was nil")
//}
//
//var nn: Int?
//n = 5
//nn = 10
//if let k = n, let kk = nn {
//    print ("n and nn had a value: \(k + kk)")
//}else{
//    print("n or nn was nil")
//}
//
//var nnnn: Int?
//nnnn = 5
//print (nnnn!)
//
//func search(lookFor n: Int, inArray data: [Int])->Int?{
//    for i in 0..<data.count{
//        if n == data[i] {return i}
//    }
//    return nil
//}
//
//print ("search result: \(search(lookFor: 5, inArray: [12,13,4,2,5,6,7]))")

//func doubleValues(data: inout[Int])
