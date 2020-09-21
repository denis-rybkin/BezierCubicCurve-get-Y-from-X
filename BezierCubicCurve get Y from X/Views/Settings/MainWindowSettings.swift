//
//  MainWindowSettings.swift
//  BezierCubicCurve get Y from X
//
//  Created by Den on 8/13/18.
//  Copyright © 2018 MicroGameDev. All rights reserved.
//

import Cocoa

class MainWindowSettings {
    
    static let shared = MainWindowSettings()
    private init() {
    }
    
    let contentSize = CGSize(width: 640, height: 480)
    private let appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
    
    func applyFor(_ window: NSWindow?) {
        
        if window == nil {
            return
        }
        window?.appearance = self.appearance
        window?.minSize = self.contentSize
        window?.maxSize = self.contentSize
        window?.setContentSize(self.contentSize)
        
    }
    
}
