//
//  ViewController.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let windowSettings = MainWindowSettings.shared
    let bezierView = BezierView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }

    func setup() {
        
        setupView()
        setupMouseTracking()
        
    }
    
    func setupView() {
        
        let bezierViewFrame = NSRect(origin: .zero, size: windowSettings.contentSize)
        bezierView.frame = bezierViewFrame
        self.view.addSubview(bezierView)
        
    }
    
    func setupMouseTracking() {
        
        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) {
            self.bezierView.setMouseLocation(mousePoint: self.view.window!.mouseLocationOutsideOfEventStream)
            return $0
        }
        
    }

}

