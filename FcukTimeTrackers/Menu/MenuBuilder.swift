import Cocoa

class MenuBuilder {
    static var appDelegate: AppDelegate?

    static func setupMenu(isScriptRunning: Bool, runningUntil: Date?, target: AnyObject) -> NSMenu {
        let menu = NSMenu()
        
        let startStopItem = Utility.buildStartInfoItem(isScriptRunning: isScriptRunning, runningUntil: runningUntil)
        menu.addItem(startStopItem)

        menu.addItem(NSMenuItem.separator())
        
        let minutesMenu = TimeMenuBuilder.buildMinutesMenu(target: target, action: #selector(AppDelegate.startSession(_:)))
        menu.setSubmenu(minutesMenu, for: menu.addItem(withTitle: "Minutes", action: nil, keyEquivalent: ""))
        
        let hoursMenu = TimeMenuBuilder.buildHoursMenu(target: target, action: #selector(AppDelegate.startSession(_:)))
        menu.setSubmenu(hoursMenu, for: menu.addItem(withTitle: "Hours", action: nil, keyEquivalent: ""))
        
        let otherTimeMenu = CustomTimeMenuBuilder.buildOtherTimeMenu(target: target, action: #selector(AppDelegate.startCustomSession))
        menu.setSubmenu(otherTimeMenu, for: menu.addItem(withTitle: "Other Time", action: nil, keyEquivalent: ""))
        
        menu.addItem(NSMenuItem.separator())
        
        if let dynamicItem = Utility.buildDynamicItem(isScriptRunning: isScriptRunning, target: target, action: #selector(AppDelegate.stopSession)) {
            menu.addItem(dynamicItem)
        }

        let quitItem = Utility.buildQuitMenuItem(target: target, action: #selector(AppDelegate.quitApplication))
        menu.addItem(quitItem)

        return menu
    }
}