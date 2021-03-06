//
//  TextField.swift
//  Random Word
//

import Cocoa

class TextField: NSTextField {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
        if (menuItem.action == Selector("copy:")) {
            return true;
        }
        return false;
    }
    
    func copy(sender: AnyObject) {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.clearContents()
        pasteboard.setString(self.stringValue, forType: NSPasteboardTypeString)
    }
    
}
