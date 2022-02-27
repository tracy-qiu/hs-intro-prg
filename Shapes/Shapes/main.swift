//
//  main.swift
//  Shapes
//
//  Created by Tracy Qiu on 1/30/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Foundation

var c = Circle(5)
print (c)

var t1 = RightTriangle(leg1: 3, leg2: 4)
print (t1)

var t2 = IsoscelesRightTriangle(leg: 3)
print (t2)

var t3 = Rectangle(length: 3, width: 2)
print (t3)

var t4 = Square(side: 6)
print (t4)

print ("\n\n\n")
var shapes = [Shape]()

shapes.append(Circle(5))
shapes.append(Circle(10))
shapes.append(RightTriangle(leg1: 3, leg2: 4))
shapes.append(RightTriangle(leg1: 5, leg2: 12))
shapes.append(IsoscelesRightTriangle(leg: 3))
shapes.append(IsoscelesRightTriangle(leg: 6))

for s in shapes {print(s)}
