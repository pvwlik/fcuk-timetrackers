import Cocoa

class IconManager {
    static var appDelegate: AppDelegate?

    static func resizeImage(image: NSImage, to size: NSSize) -> NSImage {
        let newImage = NSImage(size: size)
        newImage.lockFocus()
        image.draw(in: NSRect(origin: .zero, size: size),
                   from: NSRect(origin: .zero, size: image.size),
                   operation: .sourceOver,
                   fraction: 1.0)
        newImage.unlockFocus()
        newImage.isTemplate = image.isTemplate
        return newImage
    }

    static func updateIcon() {
        guard let appDelegate = appDelegate else { return }
        if let button = appDelegate.statusItem?.button {
            let iconName = appDelegate.isScriptRunning ? "middle_finger" : "crossed_fingers"
            if let icon = NSImage(named: NSImage.Name(iconName)) {
                button.image = resizeImage(image: icon, to: NSSize(width: 18, height: 18))
                button.image?.isTemplate = true
            }
        }
    }
}