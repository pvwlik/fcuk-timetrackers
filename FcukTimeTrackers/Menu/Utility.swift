import Cocoa

class Utility {
    static func buildStartInfoItem(isScriptRunning: Bool, runningUntil: Date?) -> NSMenuItem {
        if isScriptRunning {
            let title = "Active! Running until " + formattedRunningUntil(runningUntil: runningUntil)
            return NSMenuItem(title: title, action: nil, keyEquivalent: "")
        } else {
            let item = NSMenuItem(title: "Start new session", action: nil, keyEquivalent: "")
            item.isEnabled = false
            return item
        }
    }

    static func buildDynamicItem(isScriptRunning: Bool, target: AnyObject, action: Selector) -> NSMenuItem? {
        if isScriptRunning {
            let item = NSMenuItem(title: "Stop current session", action: action, keyEquivalent: "")
            return item
        } else {
            return nil
        }
    }

    static func buildQuitMenuItem(target: AnyObject, action: Selector) -> NSMenuItem {
        let quitItem = NSMenuItem(title: "Quit", action: action, keyEquivalent: "q")
        quitItem.target = target
        return quitItem
    }

    static func formattedRunningUntil(runningUntil: Date?) -> String {
        guard let runningUntil = runningUntil else { return "N/A" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        return dateFormatter.string(from: runningUntil)
    }
}