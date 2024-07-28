import Cocoa
import Carbon

class EventSimulator {

    static func simulateCmdTab() {
        KeyboardSimulator.simulateCmdTab()
    }
    
    static func moveCursor(from startPoint: CGPoint, to endPoint: CGPoint, withEasing easing: Int) {
        MouseSimulator.moveCursor(from: startPoint, to: endPoint, withEasing: easing)
    }
    
    static func doubleClickMouse(at x: Int, y: Int) {
        MouseSimulator.doubleClickMouse(at: x, y: y)
    }
}
