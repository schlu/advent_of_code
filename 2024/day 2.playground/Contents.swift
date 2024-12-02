import UIKit

func isSafe(levels: [Int]) -> Bool {
    var last = -1
    var increasing = false
    var loopSafe = true
    for i in 0..<levels.count {
        let current = levels[i]
        if i == 1 {
            increasing = current > last
        }
        if i > 0 {
            if increasing {
                let diff = current - last
                if diff < 1 || diff > 3 {
                    loopSafe = false
                }
            } else {
                let diff = last - current
                if diff < 1 || diff > 3 {
                    loopSafe = false
                }
            }
        }
        last = current
    }
    return loopSafe
}

for task in ["task 1", "task 2"] {
    var safe = 0

    for line in input.split(separator: "\n") {
        let levels = line.split(separator: " ").map { Int($0)! }

        if isSafe(levels: levels) {
            safe += 1
        } else {
            if task == "task 2" {
                for i in 0..<levels.count {
                    var newLevels = levels
                    newLevels.remove(at: i)
                    if isSafe(levels: newLevels) {
                        safe += 1
                        break
                    }
                }
            }
        }
    }

    print("\(task): \(safe)")
}

