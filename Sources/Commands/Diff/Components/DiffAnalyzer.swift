//
//  DiffAnalyzer.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 26/2/25.
//

import Foundation

import Foundation

/// A class that computes and logs differences between two JSON or text files.
struct DiffAnalyzer {

    /// Computes the diff between two JSON objects and groups changes under the same key.
    /// - Parameters:
    ///   - oldJson: The original JSON.
    ///   - newJson: The modified JSON.
    ///   - path: The current JSON key path.
    /// - Returns: A dictionary where keys are high-level JSON paths, and values are lists of changes.
    private func diffJSON(
        oldJson: Any,
        newJson: Any,
        path: String = ""
    ) -> [String: [String]] {
        var groupedDiffs = [String: [String]]()

        if let oldDict = oldJson as? [String: Any], let newDict = newJson as? [String: Any] {
            let allKeys = Set(oldDict.keys).union(newDict.keys)
            for key in allKeys {
                let newPath = path.isEmpty ? key : "\(path).\(key)"
                if let oldValue = oldDict[key], let newValue = newDict[key] {
                    if !isEqual(oldValue, newValue) {
                        let subDiffs = diffJSON(oldJson: oldValue, newJson: newValue, path: newPath)
                        for (subPath, changes) in subDiffs {
                            groupedDiffs[subPath, default: []].append(contentsOf: changes)
                        }
                    }
                } else if let newValue = newDict[key] {
                    groupedDiffs[path, default: []].append("+ Added: \(key) -> \(newValue)")
                } else if let oldValue = oldDict[key] {
                    groupedDiffs[path, default: []].append("- Removed: \(key) -> \(oldValue)")
                }
            }
        } else if let oldArray = oldJson as? [Any], let newArray = newJson as? [Any] {
            let maxCount = max(oldArray.count, newArray.count)
            for index in 0..<maxCount {
                let newPath = "\(path)[\(index)]"
                if index < oldArray.count, index < newArray.count {
                    if !isEqual(oldArray[index], newArray[index]) {
                        let subDiffs = diffJSON(oldJson: oldArray[index], newJson: newArray[index], path: newPath)
                        for (subPath, changes) in subDiffs {
                            groupedDiffs[subPath, default: []].append(contentsOf: changes)
                        }
                    }
                } else if index < newArray.count {
                    groupedDiffs[path, default: []].append("+ Added: [\(index)] -> \(newArray[index])")
                } else {
                    groupedDiffs[path, default: []].append("- Removed: [\(index)] -> \(oldArray[index])")
                }
            }
        } else {
            groupedDiffs[path, default: []].append("- Removed: \(oldJson)")
            groupedDiffs[path, default: []].append("+ Added: \(newJson)")
        }

        return groupedDiffs
    }

    /// Checks if two JSON values are equal.
    /// - Parameters:
    ///   - lhs: The first value.
    ///   - rhs: The second value.
    /// - Returns: A boolean indicating whether the values are equal.
    private func isEqual(_ lhs: Any, _ rhs: Any) -> Bool {
        if let lhsString = lhs as? String, let rhsString = rhs as? String {
            return lhsString == rhsString
        }

        if let lhsObj = lhs as? NSObject, let rhsObj = rhs as? NSObject {
            return lhsObj.isEqual(rhsObj)
        }

        guard JSONSerialization.isValidJSONObject(lhs),
              JSONSerialization.isValidJSONObject(rhs) else {
            return String(describing: lhs) == String(describing: rhs)
        }

        let lhsData = try? JSONSerialization.data(withJSONObject: lhs, options: .sortedKeys)
        let rhsData = try? JSONSerialization.data(withJSONObject: rhs, options: .sortedKeys)

        return lhsData == rhsData
    }

    /// Computes the structured diff between two JSON files.
    /// - Parameters:
    ///   - oldContent: The original JSON content.
    ///   - newContent: The modified JSON content.
    /// - Returns: A structured JSON diff string.
    private func computeJsonDiff(oldContent: String, newContent: String) async -> String {
        guard
            let oldData = oldContent.data(using: .utf8),
            let newData = newContent.data(using: .utf8),
            let oldJson = try? JSONSerialization.jsonObject(with: oldData),
            let newJson = try? JSONSerialization.jsonObject(with: newData)
        else {
            return "❌ Error parsing JSON."
        }

        let diffResult = diffJSON(oldJson: oldJson, newJson: newJson)

        if diffResult.isEmpty {
            return "No changes detected."
        }

        var formattedDiff = [String]()
        var lastMainKey: String?

        for (key, changes) in diffResult.sorted(by: { $0.key < $1.key }) {
            let mainKey = key.replacingOccurrences(of: "\\[\\d+\\]", with: "", options: .regularExpression)

            // Avoid duplicating headers
            if lastMainKey != mainKey {
                formattedDiff.append("\(mainKey):")
                lastMainKey = mainKey
            }

            for change in changes {
                let cleanChange = change.replacingOccurrences(of: "\\[\\d+\\] -> ", with: "", options: .regularExpression)
                formattedDiff.append("  \(cleanChange)") // Proper indentation
            }
        }

        return formattedDiff.joined(separator: "\n")
    }

    /// Determines if the content is JSON by checking the first non-whitespace character.
    /// - Parameter content: The file content.
    /// - Returns: A boolean indicating whether the content is JSON.
    private func isJSONContent(_ content: String) -> Bool {
        guard let firstChar = content.trimmingCharacters(in: .whitespacesAndNewlines).first else {
            return false
        }
        return firstChar == "{" || firstChar == "["
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
    ) async {
        guard
            let oldContent = file1Path.fileContents,
            let newContent = file2Path.fileContents,
            isJSONContent(oldContent),
            isJSONContent(newContent)
        else {
            print("❌ Error reading files.")
            return
        }

        let diff = await computeJsonDiff(oldContent: oldContent, newContent: newContent)
        if diff.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("No changes detected.")
        } else {
            writeDiffToFile(diffContent: diff, outputPath: outputFilePath)
        }
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
    }
}
