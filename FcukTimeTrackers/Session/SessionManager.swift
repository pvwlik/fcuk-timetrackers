import Cocoa

class SessionManager {
    static var appDelegate: AppDelegate?

    static func startSession(duration: Int) {
        guard let appDelegate = appDelegate else { return }
        appDelegate.runningUntil = Date().addingTimeInterval(TimeInterval(duration))
        ScriptRunner.startScript(for: duration)
    }

    static func stopSession() {
        ScriptRunner.stopScript()
    }

    static func startCustomSession() {
        guard let appDelegate = appDelegate, let customTimeTextField = appDelegate.customTimeTextField else { return }
        let customTimeString = customTimeTextField.stringValue

        guard let customTime = Int(customTimeString), customTime > 0 else {
            let alert = NSAlert()
            alert.messageText = "Invalid Input"
            alert.informativeText = "Please enter a valid number of minutes."
            alert.alertStyle = .warning
            alert.runModal()
            return
        }

        appDelegate.runningUntil = Calendar.current.date(byAdding: .minute, value: customTime, to: Date())
        ScriptRunner.startScript(for: customTime * 60)
    }
}