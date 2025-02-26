//
//  DiffAnalyzer.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 26/2/25.
//

import Foundation

/// A class that computes and logs differences between two text files.
struct DiffAnalyzer {
    /// Represents a single change in a diff.
    private enum DiffChange {
        case added(String)
        case removed(String)
        case unchanged(String)
    }

    /// Computes the line-by-line diff between two sets of lines.
    /// - Parameters:
    ///   - oldLines: The original lines.
    ///   - newLines: The modified lines.
    /// - Returns: An array of `DiffChange` elements.
    private func diffLines(_ oldLines: [String], _ newLines: [String]) -> [DiffChange] {
        var result = [DiffChange]()
        var oldIndex = 0
        var newIndex = 0

        while oldIndex < oldLines.count || newIndex < newLines.count {
            if oldIndex < oldLines.count, newIndex < newLines.count, oldLines[oldIndex] == newLines[newIndex] {
                result.append(.unchanged(oldLines[oldIndex]))
                oldIndex += 1
                newIndex += 1
            } else if newIndex < newLines.count, !oldLines.contains(newLines[newIndex]) {
                result.append(.added(newLines[newIndex]))
                newIndex += 1
            } else if oldIndex < oldLines.count, !newLines.contains(oldLines[oldIndex]) {
                result.append(.removed(oldLines[oldIndex]))
                oldIndex += 1
            } else {
                oldIndex += 1
                newIndex += 1
            }
        }

        return result
    }

    /// Computes the diff between two strings and formats the result.
    /// - Parameters:
    ///   - oldContent: The original file content.
    ///   - newContent: The modified file content.
    /// - Returns: A formatted diff string.
    private func computeDiff(oldContent: String, newContent: String) -> String {
        let oldLines = oldContent.components(separatedBy: .newlines)
        let newLines = newContent.components(separatedBy: .newlines)

        var diffResult = [String]()
        let diff = diffLines(oldLines, newLines)

        for change in diff {
            switch change {
            case .added(let line):
                diffResult.append("+ \(line)")
                print("\u{001B}[32m+ \(line)\u{001B}[0m") // Green for additions
            case .removed(let line):
                diffResult.append("- \(line)")
                print("\u{001B}[31m- \(line)\u{001B}[0m") // Red for removals
            case .unchanged(let line):
                diffResult.append("  \(line)") // Unchanged lines are written but not printed
            }
        }

        return diffResult.joined(separator: "\n")
    }

    /// Writes the diff output to a file.
    /// - Parameters:
    ///   - diffContent: The diff text.
    ///   - outputPath: The file path where the diff should be saved.
    private func writeDiffToFile(diffContent: String, outputPath: String) {
        do {
            try diffContent.write(toFile: outputPath, atomically: true, encoding: .utf8)
            print("✅ Diff written to \(outputPath)")
        } catch {
            print("❌ Error writing diff to file: \(error)")
        }
    }

    /// Runs the diffing process, logs the output, and writes it to a file.
    /// - Parameters:
    ///   - file1Path: Path to the first file.
    ///   - file2Path: Path to the second file.
    ///   - outputFilePath: Path to the output file.
    func analyzeDiff(
        file1Path: String,
        file2Path: String,
        outputFilePath: String
    ) {
        guard
            let oldContent = file1Path.fileContents,
            let newContent = file2Path.fileContents
        else {
            print("❌ Error reading files.")
            return
        }

        let diff = computeDiff(oldContent: oldContent, newContent: newContent)

        if diff.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("No changes detected.")
        } else {
            writeDiffToFile(diffContent: diff, outputPath: outputFilePath)
        }
    }
}

extension String {

    var fileContents: String? {
        guard
            let data = FileManager.default.contents(atPath: self),
            let result = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return result
//        try? .init(contentsOfFile: self, encoding: .utf8)
    }
}
