import UIKit
import PlaygroundSupport

let path = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try! String(contentsOf: path, encoding: String.Encoding.utf8)

func rotate45Degrees<T>(array: [[T]], isReversed: Bool = false) -> [[T]] {
    let m = array.count // Number of rows
    let n = array[0].count // Number of columns
    let diagonalsCount = m + n - 1
    let offset = isReversed ? m - 1 : 0
    var result = Array(repeating: [T](), count: diagonalsCount)

    for i in 0..<m {
        for j in 0..<n {
            let diagonalIndex = isReversed ? j - i + offset : i + j
            result[diagonalIndex].append(array[i][j])
        }
    }

    return result
}

func findXmas(array: [[String]]) -> Int {
    var count = 0
    for letters in array {
        for line in [letters, letters.reversed()] {
            var current = ""
            for letter in line {
                if letter == "X" {
                    current = letter
                } else {
                    switch current {
                    case "X":
                        if letter == "M" {
                            current += letter
                        } else {
                            current = ""
                        }
                    case "XM":
                        if letter == "A" {
                            current += letter
                        } else {
                            current = ""
                        }
                    case "XMA":
                        if letter == "S" {
                            count += 1
                            current = ""
                        } else {
                            current = ""
                        }
                    default:
                        current = ""
                    }
                }
            }
        }
    }
    return count
}

let horizontal = input.split(separator: "\n").map { line in
    line.split(separator: "").map(String.init)
}

var vertical: [[String]] = []
for i in 0..<horizontal[0].count {
    var row: [String] = []
    for j in 0..<horizontal.count {
        row.append(horizontal[j][i])
    }
    vertical.append(row)
}

var diagonal: [[String]] = rotate45Degrees(array: horizontal)
var antiDiagnonal: [[String]] = rotate45Degrees(array: horizontal, isReversed: true)

let horizontalCount = findXmas(array: horizontal)
let verticalCount = findXmas(array: vertical)
let diagonalCount = findXmas(array: diagonal)
let antiDiagnonalCount = findXmas(array: antiDiagnonal)

print("Part 1: \(horizontalCount + verticalCount + diagonalCount + antiDiagnonalCount)")


func diagonal(x: Int, y: Int, backwords: Bool, letters: Int) -> String {
    var ret = ""
    for i in 0..<letters {
        if backwords {
            ret += horizontal[y + i][x - i]
        } else {
            ret += horizontal[y + i][x + i]
        }
    }
    return ret
}


var xCount = 0
for i in 0..<(horizontal.count - 2) {
    for j in 0..<(horizontal[i].count - 2) {
        if horizontal.count > i && horizontal[i].count > i {
            let first = diagonal(x: j, y: i, backwords: false, letters: 3)
            if first == "SAM" || first == "MAS" {
                let second = diagonal(x: j + 2, y: i, backwords: true, letters: 3)
                if second == "SAM" || second == "MAS" {
                    xCount += 1
                }
            }
        }
    }
}

print("Part 2: \(xCount)")
