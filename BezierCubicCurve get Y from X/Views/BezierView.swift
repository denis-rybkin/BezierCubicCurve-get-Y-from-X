//
//  BezierView.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Cocoa

class BezierView: NSView {
    
    let bezierPoints = BezierCurvePoints.shared
    let viewModel = BezierViewModel.shared
    let uiSelector = UISelector.shared

    let spacingFromWindowBounds = BezierViewModel.shared.spacingFromWindowBounds
    
    let pointSize: CGFloat = 5
    let highlightedPointColor = NSColor.white
    let unhighlightedPointColor = NSColor.gray
    
    private(set) var mouseLocation = CGPoint()
    var yFromXCGFloat: CGFloat? = nil
    
    let limitYLabel: NSTextField = {
        let label = NSTextField()
        label.stringValue     = "100"
        label.frame           = NSRect(x: 70, y: 370, width: 110, height: 20)
        label.isEditable      = false
        label.isSelectable    = false
        label.textColor       = .white
        label.backgroundColor = .controlColor
        label.drawsBackground = false
        label.isBezeled       = false
        label.alignment       = .natural
        //label.font            = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
        label.font            = NSFont.systemFont(ofSize: 12)
        label.lineBreakMode   = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps     = false
        return label
    }()
    
    let limitXLabel: NSTextField = {
        let label = NSTextField()
        label.stringValue     = "150"
        label.frame           = NSRect(x: 530, y: 75, width: 110, height: 20)
        label.isEditable      = false
        label.isSelectable    = false
        label.textColor       = .white
        label.backgroundColor = .controlColor
        label.drawsBackground = false
        label.isBezeled       = false
        label.alignment       = .natural
        //label.font            = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
        label.font            = NSFont.systemFont(ofSize: 12)
        label.lineBreakMode   = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps     = false
        return label
    }()
    
    let zeroYLabel: NSTextField = {
        let label = NSTextField()
        label.stringValue     = "0"
        label.frame           = NSRect(x: 80, y: 90, width: 110, height: 20)
        label.isEditable      = false
        label.isSelectable    = false
        label.textColor       = .white
        label.backgroundColor = .controlColor
        label.drawsBackground = false
        label.isBezeled       = false
        label.alignment       = .natural
        //label.font            = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
        label.font            = NSFont.systemFont(ofSize: 12)
        label.lineBreakMode   = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps     = false
        return label
    }()
    
    let zeroXLabel: NSTextField = {
        let label = NSTextField()
        label.stringValue     = "0"
        label.frame           = NSRect(x: 95, y: 70, width: 110, height: 20)
        label.isEditable      = false
        label.isSelectable    = false
        label.textColor       = .white
        label.backgroundColor = .controlColor
        label.drawsBackground = false
        label.isBezeled       = false
        label.alignment       = .natural
        //label.font            = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
        label.font            = NSFont.systemFont(ofSize: 12)
        label.lineBreakMode   = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps     = false
        return label
    }()
    
    let yFromXLabel: NSTextField = {
        let label = NSTextField()
        label.stringValue     = "test"
        label.frame           = NSRect(x: 65, y: 170, width: 110, height: 20)
        label.isEditable      = false
        label.isSelectable    = false
        label.textColor       = .white
        label.backgroundColor = .controlColor
        label.drawsBackground = false
        label.isBezeled       = false
        label.alignment       = .natural
        //label.font            = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
        label.font            = NSFont.systemFont(ofSize: 12)
        label.lineBreakMode   = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps     = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(limitYLabel)
        addSubview(limitXLabel)
        addSubview(zeroYLabel)
        addSubview(zeroXLabel)
        addSubview(yFromXLabel)
        
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        drawBezierCurveBorders()
        drawBezierCurve()
        drawBezierPoints()
        drawCpLines()
        drawMouseCursor()
        drawYfromXLine()
        drawYfromXPoint()
        drawYfromXLabel()
        
    }
    
    private func drawBezierCurveBorders() {
        
        let width = self.bounds.width - (spacingFromWindowBounds * 2)
        let height = self.bounds.height - (spacingFromWindowBounds * 2)
        let boundsRect = NSRect(x: spacingFromWindowBounds,
                                y: spacingFromWindowBounds,
                                width: width,
                                height: height)
        let bounds = NSBezierPath(roundedRect: boundsRect,
                                  xRadius: 2,
                                  yRadius: 2)
        NSColor.lightGray.set()
        bounds.stroke()
        
    }
    
    private func drawBezierCurve() {
        
        let bezierCurve = NSBezierPath()
        bezierCurve.move(to: getPoint(.p1))
        bezierCurve.curve(to: getPoint(.p2),
                          controlPoint1: getPoint(.cp1),
                          controlPoint2: getPoint(.cp2))
        NSColor.white.set()
        bezierCurve.lineWidth = 0.3
        bezierCurve.stroke()
        
    }
    
    private func draw(_ point: BezierCurvePoints.BezierPointType) {
        
        let pointRect = getPointRect(point: point)
        let pointCircle = NSBezierPath(ovalIn: pointRect)
        
        if let selectedPoint = UISelector.shared.point {
            if selectedPoint == point {
                highlightedPointColor.set()
            } else {
                unhighlightedPointColor.set()
            }
        } else {
            unhighlightedPointColor.set()
        }
        pointCircle.stroke()
        
    }
    
    private func getPointRect(point: BezierCurvePoints.BezierPointType) -> NSRect {
        
        let cgPoint = viewModel.getCGPoint(point)
        let pointRectOrigin = NSPoint(x: cgPoint.x - pointSize/2,
                                      y: cgPoint.y - pointSize/2)
        let pointRectSize = NSSize(width: pointSize,
                                   height: pointSize)
        let pointRect = NSRect(origin: pointRectOrigin,
                               size: pointRectSize)
        return pointRect
        
    }
    
    private func drawBezierPoints() {
        
        draw(.p1)
        draw(.cp1)
        draw(.p2)
        draw(.cp2)
        
    }
    
    private func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        
        let line = NSBezierPath()
        line.move(to: fromPoint)
        line.line(to: toPoint)
        NSColor.white.set()
        line.lineWidth = 0.3
        line.stroke()
        
    }
    
    private func drawCpLines() {
        
        drawLine(fromPoint: getPoint(.p1), toPoint: getPoint(.cp1))
        drawLine(fromPoint: getPoint(.p2), toPoint: getPoint(.cp2))
        
    }
    
    private func getPoint(_ point: BezierCurvePoints.BezierPointType) -> CGPoint {
        return viewModel.getCGPoint(point)
    }
    
    private func isMouseInsideBezierCurveViewRect(mousePoint: CGPoint) -> Bool {
        
        let bezierCurveRect = viewModel.bezierCurveViewRect()
        if bezierCurveRect.contains(mousePoint) {
            return true
        }
        return false
        
    }
    
    func setMouseLocation(mousePoint: CGPoint) {
        self.mouseLocation = mousePoint
        needsDisplay = true
    }
    
    private func drawMouseCursor() {
        
        if isMouseInsideBezierCurveViewRect(mousePoint: mouseLocation) == false {
            return
        }
        let heightY: CGFloat = viewModel.spacingFromWindowBounds + viewModel.bezierCurveViewRect().height
        let zeroY = viewModel.bezierCurveViewRect().origin.y
        let x = mouseLocation.x
        let p1 = CGPoint(x: x, y: heightY)
        let p2 = CGPoint(x: x, y: zeroY)
        drawLine(fromPoint: p1, toPoint: p2)
        
    }
    
    private func drawYfromXLine() {
        
        if self.yFromXCGFloat == nil {
            return
        }
        if isMouseInsideBezierCurveViewRect(mousePoint: mouseLocation) == false {
            return
        }
        let zeroX = viewModel.bezierCurveViewRect().origin.x
        yFromXCGFloat = yFromXCGFloat! + viewModel.spacingFromWindowBounds
        let p1 = CGPoint(x: zeroX, y: yFromXCGFloat!)
        let p2 = CGPoint(x: mouseLocation.x, y: yFromXCGFloat!)
        drawLine(fromPoint: p1, toPoint: p2)
        
    }
    
    private func drawYfromXPoint() {
        
        if isMouseInsideBezierCurveViewRect(mousePoint: mouseLocation) == false {
            return
        }
        let mouse = viewModel.convertCGtoBezierData(point: mouseLocation)
        let y = CubicCalculator.shared.getY(fromX: Double(mouse.x),
                                            p1: BezierCurvePoints.shared.p1,
                                            cp1: BezierCurvePoints.shared.cp1,
                                            p2: BezierCurvePoints.shared.p2,
                                            cp2: BezierCurvePoints.shared.cp2)
        if y == nil {
            self.yFromXCGFloat = nil
            return
        }
        let yFromXPoint = BezierCurvePoints.Point(x: mouse.x,
                                                  y: y!)
        var cgPoint = viewModel.convertBezierDataToCG(point: yFromXPoint)
        self.yFromXCGFloat = cgPoint.y
        viewModel.addOriginOffset(toPoint: &cgPoint)
        let pointRectOrigin = NSPoint(x: cgPoint.x - pointSize/2,
                                      y: cgPoint.y - pointSize/2)
        let pointRectSize = NSSize(width: pointSize,
                                   height: pointSize)
        let pointRect = NSRect(origin: pointRectOrigin,
                               size: pointRectSize)
        let pointCircle = NSBezierPath(ovalIn: pointRect)
        NSColor.white.set()
        pointCircle.fill()
        NSColor.darkGray.set()
        pointCircle.stroke()
        
    }
    
    private func drawYfromXLabel() {
        
        if yFromXCGFloat == nil {
            self.yFromXLabel.isHidden = true
            return
        } else {
            self.yFromXLabel.isHidden = false
        }
        let y = yFromXCGFloat! + viewModel.spacingFromWindowBounds - 10
        let origin = CGPoint(x: self.yFromXLabel.frame.origin.x,
                             y: y)
        
        let mouse = viewModel.convertCGtoBezierData(point: mouseLocation)
        let yFromX = CubicCalculator.shared.getY(fromX: Double(mouse.x),
                                            p1: BezierCurvePoints.shared.p1,
                                            cp1: BezierCurvePoints.shared.cp1,
                                            p2: BezierCurvePoints.shared.p2,
                                            cp2: BezierCurvePoints.shared.cp2)
        if yFromX == nil {
            
            return
        }
        let formattedY = String(format: "%.1f", yFromX!)
        self.yFromXLabel.stringValue = formattedY
        self.yFromXLabel.setFrameOrigin(origin)
    
    }
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convert(event.locationInWindow, from: nil)
        
        switch true {
        case getPointRect(point: .p1).contains(mousePoint):
            uiSelector.point = .p1
        case getPointRect(point: .p2).contains(mousePoint):
            uiSelector.point = .p2
        case getPointRect(point: .cp1).contains(mousePoint):
            uiSelector.point = .cp1
        case getPointRect(point: .cp2).contains(mousePoint):
            uiSelector.point = .cp2
        default:
            uiSelector.point = nil
        }
        needsDisplay = true
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        let mousePoint = convert(event.locationInWindow, from: nil)
        self.setMouseLocation(mousePoint: mousePoint)
        if isMouseInsideBezierCurveViewRect(mousePoint: mousePoint) == false {
            return
        }
        if uiSelector.point == nil {
            return
        }
        
        let newPoint = viewModel.convertCGtoBezierData(point: mousePoint)
    
        switch true {
        case uiSelector.point == .p1:
            bezierPoints.p1 = newPoint
        case uiSelector.point == .cp1:
            bezierPoints.cp1 = newPoint
        case uiSelector.point == .p2:
            bezierPoints.p2 = newPoint
        case uiSelector.point == .cp2:
            bezierPoints.cp2 = newPoint
        default:
            Swift.print("error mouseDragged()")
        }
        needsDisplay = true
    }
    
    override func viewWillMove(toWindow newWindow: NSWindow?) {

        let trackingArea = NSTrackingArea(rect: self.bounds,
                                          options: [.mouseEnteredAndExited, .activeAlways],
                                          owner: self,
                                          userInfo: nil)
        addTrackingArea(trackingArea)
        
    }
    
}





