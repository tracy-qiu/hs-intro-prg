//
//  shape.swift
//  Shapes
//
//  Created by Tracy Qiu on 1/30/18.
//  Copyright © 2018 Tracy Qiu. All rights reserved.
//

import Cocoa

enum ShapesType {
    case Shape, Circle, Square, Rectangle, RightTriangle, IsoscelesRightTriangle
}

class Shape: CustomStringConvertible {
    static var nextShapeID = 0
    var id: Int
    var type: ShapesType
    
    init() {
        id = Shape.nextShapeID
        Shape.nextShapeID += 1
        type = .Shape
    }
    
    func area() -> Double {
        fatalError ("Shape is an abstract class")
        return 0.0
    }
    
    func perimeter() -> Double {
        fatalError ("Shape is an abstract class")
        return 0.0
    }
    
    var description: String{
        return "\(type) id: \(id) area: \(area()) perimeter: \(perimeter())"
    }
}

class RightTriangle: Shape {
    let leg1: Double
    let leg2: Double
    var hypotenuse: Double {
        return sqrt(leg1 * leg1 + leg2 * leg2)
    }
    
    init (leg1:Double, leg2: Double) {
        self.leg1 = leg1
        self.leg2 = leg2
        super.init()
        type = .RightTriangle
    }
    
    override func area()-> Double { return 0.5 * leg1 * leg2}
    override func perimeter()-> Double { return leg1 + leg2 + hypotenuse}
    
    override var description: String{
        return super.description + " leg1: \(leg1) leg2: \(leg2) hypotenuse: \(hypotenuse)"
    }
}

class IsoscelesRightTriangle: RightTriangle {
    init (leg:Double){
        super.init(leg1:leg, leg2: leg)
        type = .IsoscelesRightTriangle
    }
}

class Circle: Shape {
    let radius: Double
    init (_ radius:Double) {
        self.radius = radius
        super.init()
        type = .Circle
    }
    override func area()-> Double {return Double.pi * radius * radius}
    override func perimeter() -> Double {return Double.pi * 2 * radius}
    func circumference()-> Double {return perimeter()}
    
    override var description: String{
        return super.description + " radius: \(radius)"
    }
}

class Rectangle: Shape {
    let length: Double
    let width: Double
    init (length: Double, width: Double){
        self.length = length
        self.width = width
        super.init()
        type = .Rectangle
    }
    override func area()->Double {return length * width}
    override func perimeter() -> Double {return 2*length + 2*width}
    
    override var description: String{
        return super.description + " length: \(length) width: \(width)"
    }
}

class Square: Rectangle {
    init(side:Double){
        super.init (length:side, width:side)
        type = .Square
    }
}

