import Cocoa
import CoreGraphics

class MouseSimulator {
    
    static func moveCursor(from startPoint: CGPoint, to endPoint: CGPoint, withEasing easing: Int) {
        let steps = max(easing / 10, 1)
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let stepX = dx / CGFloat(steps)
        let stepY = dy / CGFloat(steps)
        
        for i in 0...steps {
            let x = startPoint.x + (stepX * CGFloat(i))
            let y = startPoint.y + (stepY * CGFloat(i))
            let event = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: CGPoint(x: x, y: y), mouseButton: .left)
            event?.post(tap: .cghidEventTap)
            usleep(useconds_t(easing * 1000 / steps)) // Adjust sleep time for smoothness
        }
    }
    
    static func doubleClickMouse(at x: Int, y: Int) {
        let clickDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: CGPoint(x: CGFloat(x), y: CGFloat(y)), mouseButton: .left)
        let clickUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: CGPoint(x: CGFloat(x), y: CGFloat(y)), mouseButton: .left)
        
        clickDown?.post(tap: .cghidEventTap)
        clickUp?.post(tap: .cghidEventTap)
        usleep(100000) // Wait 100ms between clicks for double click
        clickDown?.post(tap: .cghidEventTap)
        clickUp?.post(tap: .cghidEventTap)
    }
}
