//
//  AppDelegate.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let windowSettings = MainWindowSettings.shared
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        
        setupWindow()
        
    }

    func setupWindow() {
        let mainWindow = NSApplication.shared.windows[0]
        mainWindow.acceptsMouseMovedEvents = true
        mainWindow.title = "Bezier Y from X"
        windowSettings.applyFor(mainWindow)
    }
    
}

