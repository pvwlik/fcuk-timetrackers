import Foundation
import AppKit

class ScriptRunner {

    static var appDelegate: AppDelegate?

    private static var timer: Timer?
    private static var scriptState = ScriptState()  // Use ScriptState instance

    static func startScript(for duration: Int) {
        guard let appDelegate = appDelegate else {
            fatalError("AppDelegate not set")
        }

        scriptState.isScriptRunning = true
        appDelegate.isScriptRunning = true
        appDelegate.onScriptStateChange()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            CommandGenerator.generateCommands(state: scriptState)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration)) {
            stopScript()
        }
    }

    static func stopScript() {
        guard let appDelegate = appDelegate else {
            fatalError("AppDelegate not set")
        }

        scriptState.isScriptRunning = false
        appDelegate.isScriptRunning = false
        appDelegate.onScriptStateChange()
        timer?.invalidate()
    }
}
