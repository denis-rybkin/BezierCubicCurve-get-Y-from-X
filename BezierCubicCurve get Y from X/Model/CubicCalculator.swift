//
//  CubicCalculator.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/14/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Foundation

class CubicCalculator {
    
    static let shared = CubicCalculator()
    private init() {
    }
    
    
    func getY(fromX: Double,
              p1: BezierCurvePoints.Point,
              cp1: BezierCurvePoints.Point,
              p2: BezierCurvePoints.Point,
              cp2: BezierCurvePoints.Point) -> Double? {
        
        if fromX < p1.x {
            return nil
        }
        if fromX > p2.x {
            return nil
        }
        
        let p1time = p1.x
        let p1value = p1.y
        let c1time = cp1.x
        let c1value = cp1.y
        
        let p2time = p2.x
        let p2value = p2.y
        let c2time = cp2.x
        let c2value = cp2.y
        
        func cubicBezier(t: CGFloat) -> CGPoint {
            let p1 = CGPoint(x: p1time, y: p1value)
            let c1 = CGPoint(x: c1time, y: c1value)
            let p2 = CGPoint(x: p2time, y: p2value)
            let c2 = CGPoint(x: c2time, y: c2value)
            let t_ = (1.0 - t)
            let tt_ = t_ * t_
            let ttt_ = t_ * t_ * t_;
            let tt = t * t;
            let ttt = t * t * t;
            let _x = p1.x * ttt_
                + 3.0 * c1.x * tt_ * t
                + 3.0 * c2.x * t_ * tt
                + p2.x * ttt
            let _y = p1.y * ttt_
                + 3.0 * c1.y * tt_ * t
                + 3.0 * c2.y * t_ * tt
                + p2.y * ttt
            return CGPoint(x: _x, y: _y)
        }
        func find_y_at(x: CGFloat) -> Double {
            var _t: CGFloat = 0.5
            var _p = cubicBezier(t: _t)
            var min_t: CGFloat = 0.0
            var max_t: CGFloat = 1.0
            let namber_iter = 10
            for _ in 1...namber_iter {
                if _p.x > x {
                    max_t = _t
                    _t = ((max_t - min_t) / 2) + min_t
                } else {
                    min_t = _t
                    _t = ((max_t - min_t) / 2) + min_t
                }
                _p = cubicBezier(t: _t)
            }
            return Double(_p.y)
        }
        return find_y_at(x: CGFloat(fromX))
        
    }
    
    
    
    
    
    
    
    
    
}


