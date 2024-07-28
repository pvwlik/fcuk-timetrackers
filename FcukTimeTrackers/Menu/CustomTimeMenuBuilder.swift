import Cocoa

class CustomTimeMenuBuilder {
    static func buildOtherTimeMenu(target: AnyObject, action: Selector) -> NSMenu {
        guard let appDelegate = MenuBuilder.appDelegate else {
            fatalError("AppDelegate not set")
        }

        let otherTimeMenu = NSMenu()

        let customTimeItem = NSMenuItem(title: "Enter custom time", action: nil, keyEquivalent: "")
        otherTimeMenu.addItem(customTimeItem)

        let container = NSView(frame: NSRect(x: 0, y: 0, width: 150, height: 70))

        let timeTextField = NSTextField(frame: NSRect(x: 10, y: 40, width: 130, height: 24))
        timeTextField.placeholderString = "Minutes"
        container.addSubview(timeTextField)

        appDelegate.customTimeTextField = timeTextField

        let goButton = NSButton(title: "GO", target: target, action: action)
        goButton.bezelStyle = .rounded
        goButton.frame = NSRect(x: 50, y: 5, width: 50, height: 24)
        container.addSubview(goButton)

        let separator = NSBox(frame: NSRect(x: 10, y: 30, width: 130, height: 1))
        separator.boxType = .separator
        container.addSubview(separator)

        let customViewItem = NSMenuItem()
        customViewItem.view = container
        otherTimeMenu.addItem(customViewItem)

        return otherTimeMenu
    }
}