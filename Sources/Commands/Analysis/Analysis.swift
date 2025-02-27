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

    private var storage = Storage()

    func run() async throws {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: directoryPath) else {
            print("Invalid directory path.")
            return
        }

        let files = discoverFiles(with: "swift", in: directoryPath)

        var globalItems: [PublicInterfaceEntry] = []
        var jsonEntries: [JSONDeclSyntax] = []
        for fileURL in files {
            let visitor = try SourceFileVisitor(fileURL)
            let items = visitor.traverse()
            jsonEntries.append(contentsOf: visitor.values)
            storage.set(items, for: fileURL)
            globalItems.append(contentsOf: visitor.globalItems)
        }

        let source = URL(fileURLWithPath: directoryPath)
        let outputURL = URL(fileURLWithPath: outputPath)
        storage.set(
            [.container(
                nil,
                0,
                globalItems
            )],
            for: .init(fileURLWithPath: directoryPath)
        )
        let reportBuilder = ReportBuilder(storage)
        try reportBuilder.writeReport(
            for: source,
            to: outputURL
        )
        reportBuilder.logReport(for: source)
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
}
