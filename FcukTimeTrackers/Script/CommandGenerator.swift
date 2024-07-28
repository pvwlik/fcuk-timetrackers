import Foundation
import AppKit

class ScriptState {
    var isScriptRunning: Bool = false
    var isGeneratingCommands: Bool = false
}

class CommandGenerator {
    static func generateCommands(state: ScriptState) {
        guard state.isScriptRunning, !state.isGeneratingCommands else { return }
        state.isGeneratingCommands = true

        DispatchQueue.global(qos: .userInitiated).async {
            var actions = [() -> Void]()

            let numberOfCmdTabEvents = Int.random(in: 2...7)
            for _ in 1...numberOfCmdTabEvents {
                actions.append {
                    EventSimulator.simulateCmdTab()
                    usleep(useconds_t(RandomGenerator.randomDelay() * 1000))
                }
            }

            let numberOfMovements = Int.random(in: 2...7)
            var currentPosition = NSEvent.mouseLocation
            for _ in 1...numberOfMovements {
                let (x, y) = RandomGenerator.randomCoordinates()
                let easing = RandomGenerator.randomEasing()
                actions.append {
                    EventSimulator.moveCursor(from: currentPosition, to: CGPoint(x: CGFloat(x), y: CGFloat(y)), withEasing: easing)
                    usleep(useconds_t(easing * 1000))
                    usleep(useconds_t(RandomGenerator.randomDelay() * 1000))
                    currentPosition = CGPoint(x: CGFloat(x), y: CGFloat(y))
                }
            }

            let numberOfSafeMovements = Int.random(in: 2...7)
            for _ in 1...numberOfSafeMovements {
                let (x, y) = RandomGenerator.randomSafeClickCoordinates()
                actions.append {
                    EventSimulator.moveCursor(from: currentPosition, to: CGPoint(x: CGFloat(x), y: CGFloat(y)), withEasing: RandomGenerator.randomEasing())
                    usleep(useconds_t(RandomGenerator.randomDelay() * 1000))
                    EventSimulator.doubleClickMouse(at: x, y: y)
                    usleep(useconds_t(RandomGenerator.randomDelay() * 1000))
                    currentPosition = CGPoint(x: CGFloat(x), y: CGFloat(y))
                }
            }

            for action in actions.shuffled() {
                if !state.isScriptRunning { break }
                action()
            }

            DispatchQueue.main.async {
                state.isGeneratingCommands = false
            }
        }
    }
}
