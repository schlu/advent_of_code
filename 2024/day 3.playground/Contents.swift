import UIKit
import PlaygroundSupport

let path = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try! String(contentsOf: path, encoding: String.Encoding.utf8)

// Part 1
let mulRegEx = /mul\((\d+?),(\d+?)\)/

var part1 = 0
input.matches(of: mulRegEx).forEach { match in
    part1 += Int(match.1)! * Int(match.2)!
}

print(part1)


// Part 2
let instructionRegex = /(do\(\))|(don\'t\(\))|(mul\((\d+?),(\d+?)\))/
var part2 = 0
var enabled = true
input.matches(of: instructionRegex).forEach { match in
    if match.0.contains("don't") {
        enabled = false
    } else if match.0.contains("do") {
        enabled = true
    } else if enabled {
        part2 += Int(match.4!)! * Int(match.5!)!
    }
}

print(part2)
