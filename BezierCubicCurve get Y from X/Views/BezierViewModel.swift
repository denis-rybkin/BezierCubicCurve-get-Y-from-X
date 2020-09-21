//
//  BezierViewModel.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

// convert model data to CoreGraphics Points on screen


import Foundation

class BezierViewModel {
    
    static let shared = BezierViewModel()
    private init() {
    }
    
    let bezierCurveModel = BezierCurvePoints.shared
    
    let spacingFromWindowBounds: CGFloat = 50
    
    let beginX = 0.0
    let beginY = 0.0
    let limitX = 150.0
    let limitY = 100.0
    
    func convertBezierDataToCG(point: BezierCurvePoints.Point) -> CGPoint {
        
        let xMultiplier = Double(bezierCurveViewRect().width) / (limitX - beginX)
        let yMultiplier = Double(bezierCurveViewRect().height) / (limitY - beginY)
        
        let xCG = xMultiplier * point.x
        let yCG = yMultiplier * point.y
        
        return CGPoint(x: xCG, y: yCG)
        
    }
    
    func convertCGtoBezierData(point: CGPoint) -> BezierCurvePoints.Point {
        
        var p = point
        p.x -= spacingFromWindowBounds
        p.y -= spacingFromWindowBounds
        let xMultiplier = CGFloat(limitX - beginX) / bezierCurveViewRect().width
        let yMultiplier = CGFloat(limitY - beginY) / bezierCurveViewRect().height
        
        let x = Double(xMultiplier * p.x)
        let y = Double(yMultiplier * p.y)
        
        return BezierCurvePoints.Point(x: x, y: y)
    }
    
    func getCGPoint(_ point: BezierCurvePoints.BezierPointType) -> CGPoint {
        
        let pointModel = bezierCurveModel.getPoint(point)
        var cgPoint = convertBezierDataToCG(point: pointModel)
        addOriginOffset(toPoint: &cgPoint)
        return cgPoint
        
    }
    
    func addOriginOffset(toPoint: inout CGPoint) {
        
        toPoint.x += spacingFromWindowBounds
        toPoint.y += spacingFromWindowBounds
        
    }
    
    func bezierCurveViewRect() -> NSRect {
        
        var origin = CGPoint()
        addOriginOffset(toPoint: &origin)
        let windowSize = MainWindowSettings.shared.contentSize
        let size = CGSize(width: windowSize.width - (spacingFromWindowBounds * 2),
                          height: windowSize.height - (spacingFromWindowBounds * 2))
        let bezierViewRect = NSRect(origin: origin, size: size)
        return bezierViewRect
        
    }
    
}










