//
//  BezierCurvePoints.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Foundation

class BezierCurvePoints {
    
    static let shared = BezierCurvePoints()
    private init() {
    }
    
    class Point {
        var x: Double
        var y: Double
        init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
    }
    
    var p1  = Point(x: 10, y: 90)
    var cp1 = Point(x: 50, y: 90)
    var p2  = Point(x: 90, y: 10)
    var cp2 = Point(x: 50, y: 10)
    
    enum BezierPointType {
        case p1
        case cp1
        case p2
        case cp2
    }
    
    func getPoint(_ point: BezierPointType) -> Point {
        
        switch point {
        case .p1:
            return p1
        case .cp1:
            return cp1
        case .p2:
            return p2
        case .cp2:
            return cp2
        }
        
    }
    
}
