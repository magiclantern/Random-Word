//
//  WindowController.swift
//  Random Word
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.titlebarAppearsTransparent = true
        window?.movableByWindowBackground = true
        window?.titleVisibility = .Hidden
    }
}
