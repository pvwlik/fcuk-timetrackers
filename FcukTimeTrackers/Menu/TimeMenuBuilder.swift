import Cocoa

class TimeMenuBuilder {
    static func buildMinutesMenu(target: AnyObject, action: Selector) -> NSMenu {
        let minutesMenu = NSMenu(title: "Minutes")
        let minutes = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
        for minute in minutes {
            let title = minute == 1 ? "1 minute" : "\(minute) minutes"
            let item = NSMenuItem(title: title, action: action, keyEquivalent: "")
            item.tag = minute * 60
            item.target = target
            minutesMenu.addItem(item)
        }
        return minutesMenu
    }

    static func buildHoursMenu(target: AnyObject, action: Selector) -> NSMenu {
        let hoursMenu = NSMenu(title: "Hours")
        let hours = [1, 2, 3, 4, 5, 6, 7, 8]
        for hour in hours {
            let item = NSMenuItem(title: "\(hour) hour\(hour > 1 ? "s" : "")", action: action, keyEquivalent: "")
            item.tag = hour * 3600
            item.target = target
            hoursMenu.addItem(item)
        }
        return hoursMenu
    }
}