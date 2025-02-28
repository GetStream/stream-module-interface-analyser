//
//  DiffAnalyzer.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 26/2/25.
//

import Foundation

struct DiffAnalyzer {

    func analyzeDiff(
        newItems: [JSONDeclSyntax],
        oldItems: [JSONDeclSyntax],
        outputFilePath: String
    ) async throws {
        let newDictionary = dictionary(from: newItems)
        let oldDictionary = dictionary(from: oldItems)

        let newDictionaryKeys = Set(newDictionary.keys)
        let oldDictionaryKeys = Set(oldDictionary.keys)

        let addedKeys = Set(newDictionary.keys).subtracting(oldDictionaryKeys)
        let removedKeys = Set(oldDictionaryKeys).subtracting(newDictionaryKeys)
        let commonKeys = newDictionaryKeys.intersection(oldDictionaryKeys)

        let addedItems = newDictionary
            .filter { addedKeys.contains($0.key) }
            .map { $0.value }

        let removedItems = oldDictionary
            .filter { removedKeys.contains($0.key) }
            .map { $0.value }

        var changedItems = [String: (old: JSONDeclSyntax, new: JSONDeclSyntax)]()

        for commonKey in commonKeys {
            guard
                let newItem = newDictionary[commonKey],
                let oldItem = oldDictionary[commonKey],
                newItem.eraseToAnyJSONDeclSyntax() != oldItem.eraseToAnyJSONDeclSyntax()
            else {
                continue
            }
            changedItems[commonKey] = (oldItem, newItem)
        }

        print(
            """
            Public interface differences:
                added: \(addedItems.endIndex)
                removed: \(removedItems.endIndex)
                changed: \(changedItems.count)
            """
        )

        guard !addedItems.isEmpty || !removedItems.isEmpty || !changedItems.isEmpty else {
            return
        }

        var resultComponents = [String]()
        resultComponents.append(
            """
            \(addedItems.map { $0.description.asAddition }.joined(separator: "\n\n"))
            """
        )

        resultComponents.append(
            """
            \(removedItems.map { $0.description.asRemoval }.joined(separator: "\n\n"))
            """
        )

        resultComponents.append(
            """
            \(changedItems.map { generateGitHubMarkdownDiff(oldText: $0.value.old.description, newText: $0.value.new.description) }.joined(separator: "\n\n"))
            """
        )

        let result = """
        ```diff
        \(resultComponents.joined(separator: "\n\n"))
        ```
        """

        try writeToFile(result, outputPath: outputFilePath)
    }

    // MARK: - Private Helpers

    private func dictionary(
        from array: [JSONDeclSyntax]
    ) -> [String: JSONDeclSyntax] {
        var result = [String: JSONDeclSyntax]()

        for entry in array {
            if entry is GlobalJSONDeclSyntax{
                result["Global"] = entry
            } else {
                let erased = entry.eraseToAnyJSONDeclSyntax()
                let key = "\(erased.contentType)_\(erased.name ?? UUID().uuidString)"
                result[key] = entry
            }
        }

        return result
    }

    private func generateGitHubMarkdownDiff(oldText: String, newText: String) -> String {
        let oldLines = oldText.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        let newLines = newText.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n", omittingEmptySubsequences: false).map(String.init)

        var diffResult: [String] = [] // Start GitHub diff block
        var oldIndex = 0
        var newIndex = 0

        while oldIndex < oldLines.count || newIndex < newLines.count {
            if oldIndex < oldLines.count, newIndex < newLines.count {
                let oldLine = oldLines[oldIndex]
                let newLine = newLines[newIndex]

                if oldLine == newLine {
                    diffResult.append(" " + oldLine) // Unchanged line (optional)
                } else {
                    diffResult.append("- " + oldLine) // Mark as removed
                    diffResult.append("+ " + newLine) // Mark as added
                }
                oldIndex += 1
                newIndex += 1
            } else if oldIndex < oldLines.count {
                diffResult.append("- " + oldLines[oldIndex]) // Mark removed lines
                oldIndex += 1
            } else if newIndex < newLines.count {
                diffResult.append("+ " + newLines[newIndex]) // Mark added lines
                newIndex += 1
            }
        }

        return diffResult.joined(separator: "\n")
    }

    private func writeToFile(_ text: String, outputPath: String) throws {
        let fileURL = URL(fileURLWithPath: outputPath)
        try text.write(
            to: fileURL,
            atomically: true,
            encoding: .utf8
        )

        print("Diff report was successfully written to:", fileURL)
    }
}

extension String {
    var asAddition: String {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { "+ \($0)" }
            .joined(separator: "\n")
    }

    var asRemoval: String {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map { "- \($0)" }
            .joined(separator: "\n")
    }
}
