import Foundation

class RandomGenerator {
    static func randomEasing() -> Int {
        return Int.random(in: 100...500)
    }

    static func randomDelay() -> Int {
        return Int.random(in: 1000...8000)
    }

    static func randomCoordinates() -> (x: Int, y: Int) {
        return (x: Int.random(in: 0...1919), y: Int.random(in: 0...1079))
    }

    static func randomSafeClickCoordinates() -> (x: Int, y: Int) {
        return (x: Int.random(in: 100...599), y: Int.random(in: 10...29))
    }
}