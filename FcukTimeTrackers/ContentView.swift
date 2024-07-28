import SwiftUI
import Foundation

struct ContentView: View {
    @State private var isActive: Bool = false
    @State private var timer: Timer?
    @State private var selectedTime: Int = 0
    @State private var customTime: String = ""

    var body: some View {
        VStack {
            if isActive {
                Text("Active! \(minutesLeft()) minutes left")
                    .padding()
            } else {
                Text("Start new session")
                    .padding()
            }
            
            Menu("Options") {
                if isActive {
                    Button("Stop!") {
                        stopScript()
                    }
                    Divider()
                }
                
                Menu("Minutes") {
                    ForEach([5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55], id: \.self) { minutes in
                        Button("\(minutes) minutes") {
                            startScript(withDuration: minutes * 60)
                        }
                    }
                }
                
                Menu("Hours") {
                    ForEach([1, 2, 3, 4, 5, 6, 7, 8], id: \.self) { hours in
                        Button("\(hours) hour\(hours > 1 ? "s" : "")") {
                            startScript(withDuration: hours * 3600)
                        }
                    }
                }
                
                Menu("Other Time") {
                    HStack {
                        TextField("Minutes", text: $customTime)
                            .frame(width: 100)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("GO") {
                            if let minutes = Int(customTime), minutes > 0 {
                                startScript(withDuration: minutes * 60)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 300, height: 200)
    }
    
    private func startScript(withDuration duration: Int) {
        isActive = true
        runScript()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: false) { _ in
            stopScript()
        }
    }
    
    private func stopScript() {
        isActive = false
        // Implement your shell command to stop the script here
        // For example:
        // let task = Process()
        // task.launchPath = "/bin/sh"
        // task.arguments = ["-c", "pkill -f your_script_name.sh"]
        // task.launch()
        timer?.invalidate()
    }
    
    private func runScript() {
        // Implement your shell command to start the script here
        // For example:
        // let task = Process()
        // task.launchPath = "/bin/sh"
        // task.arguments = ["-c", "your_script_name.sh"]
        // task.launch()
    }
    
    private func minutesLeft() -> Int {
        // Calculate and return the remaining minutes
        // Placeholder: return a dummy value for now
        return 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
