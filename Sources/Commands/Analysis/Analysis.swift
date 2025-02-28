//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import ArgumentParser
import Foundation

struct Analysis: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Analyse a directory and generate a open/public API report."
    )

    @Argument(help: "The directory to analyze.")
    var directoryPath: String

    @Argument(help: "The file path to save the report.")
    var outputPath: String

    func run() async throws {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: directoryPath) else {
            print("Invalid directory path.")
            return
        }

        let files = discoverFiles(with: "swift", in: directoryPath)

        var items: [JSONDeclSyntax] = []
        for fileURL in files {
            let visitor = try SourceFileVisitor(fileURL)
            let visitorItems = visitor.traverse()
            items.append(contentsOf: visitorItems)
        }

        try writeJSONToFile(items.map { $0.eraseToAnyJSONDeclSyntax() })
        print("Public interface report was written successfully at \(outputPath)")
    }

    // MARK: Private Helpers

    private func discoverFiles(
        with fileExtension: String,
        in path: String
    ) -> [URL] {
        var result: [URL] = []

        guard
            let enumerator = FileManager.default.enumerator(
                at: .init(fileURLWithPath: path),
                includingPropertiesForKeys: [.isRegularFileKey],
                options: [.skipsHiddenFiles, .skipsPackageDescendants]
            )
        else {
            return result
        }

        for case let fileURL as URL in enumerator {
            do {
                let fileAttributes = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                if fileAttributes.isRegularFile!, fileURL.pathExtension == fileExtension {
                    result.append(fileURL)
                }
            } catch {
                print(error, fileURL)
            }
        }

        // ✅ Ensure consistent ordering of files
        return result.sorted(by: { $0.path < $1.path })
    }

    func writeJSONToFile<T: Encodable>(_ data: T) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys] // Pretty print + sorted keys

        let jsonData = try encoder.encode(data) // Encode the object
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw NSError(domain: "EncodingError", code: -1, userInfo: nil)
        }

        let fileURL = URL(fileURLWithPath: outputPath)
        try jsonString.write(
            to: fileURL,
            atomically: true,
            encoding: .utf8
        )

        print("JSON successfully written to:", fileURL)
    }
}
