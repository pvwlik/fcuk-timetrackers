import Cocoa

class MenuManager {
    static var appDelegate: AppDelegate?

    static func setupMenu(statusItem: NSStatusItem) {
        guard let appDelegate = appDelegate else { return }
        let menu = MenuBuilder.setupMenu(isScriptRunning: appDelegate.isScriptRunning, runningUntil: appDelegate.runningUntil, target: appDelegate)
        statusItem.menu = menu
    }

    static func updateMenu(statusItem: NSStatusItem) {
        setupMenu(statusItem: statusItem)
    }
}
