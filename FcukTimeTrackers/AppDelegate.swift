import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var shared: AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }

    var statusItem: NSStatusItem?
    var isScriptRunning = false
    var runningUntil: Date?
    var customTimeTextField: NSTextField?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ScriptRunner.appDelegate = self
        MenuBuilder.appDelegate = self
        MenuManager.appDelegate = self
        IconManager.appDelegate = self
        SessionManager.appDelegate = self

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            let icon = NSImage(named: NSImage.Name("crossed_fingers"))
            button.image = IconManager.resizeImage(image: icon!, to: NSSize(width: 18, height: 18))
            button.image?.isTemplate = true
            button.action = #selector(showMenu(_:))
        }
        
        MenuManager.setupMenu(statusItem: statusItem!)
    }
    
    @objc func showMenu(_ sender: Any?) {
        if (statusItem?.menu) != nil {
            statusItem?.button?.performClick(nil)
        }
    }
    
    @objc func startSession(_ sender: NSMenuItem) {
        SessionManager.startSession(duration: sender.tag)
    }
    
    @objc func stopSession() {
        SessionManager.stopSession()
    }
    
    @objc func startCustomSession() {
        SessionManager.startCustomSession()
    }
    
    func onScriptStateChange() {
        IconManager.updateIcon()
        MenuManager.updateMenu(statusItem: statusItem!)
    }
    
    @objc func quitApplication() {
        NSApplication.shared.terminate(self)
    }
}
