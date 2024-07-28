import IOKit.hid
import CoreGraphics
import IOKit

class KeyboardSimulator {
    
    static func simulateCmdTab() {
        let cmdKeyCode: CGKeyCode = 55 // Command key code
        let tabKeyCode: CGKeyCode = 48 // Tab key code
        
        // Press Cmd key down
        postKeyEvent(keyCode: cmdKeyCode, keyDown: true)
        
        // Press Tab key down
        postKeyEvent(keyCode: tabKeyCode, keyDown: true)
        postKeyEvent(keyCode: tabKeyCode, keyDown: false)
        
        // Release Cmd key
        postKeyEvent(keyCode: cmdKeyCode, keyDown: false)
    }
    
    private static func postKeyEvent(keyCode: CGKeyCode, keyDown: Bool) {
        let event = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: keyDown)
        event?.post(tap: .cghidEventTap)
        usleep(150000) // Wait for 150 ms to ensure the event is processed
    }
}
