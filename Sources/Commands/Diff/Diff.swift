//
//  Diff.swift
//  SwiftPublicInterfaceValidator
//
//  Created by Ilias Pavlidakis on 21/2/25.
//

import SwiftSyntax
import ArgumentParser
import Foundation

extension String: @retroactive Error {}

struct Diff: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Compare two reports and create a diff visualisation."
    )

    @Argument(help: "The url pointing to the first report.")
    var fileA: String

    @Argument(help: "The url pointing to the second report.")
    var fileB: String

    @Argument(help: "The output path where the markdown file will be created.")
    var outputPath: String

    func run() async throws {
        let jsonFileA = try readJSONFromFile(from: fileA)
        let jsonFileB = try readJSONFromFile(from: fileB)

        let analyser = DiffAnalyzer()
        try await analyser.analyzeDiff(
            newItems: jsonFileA,
            oldItems: jsonFileB,
            outputFilePath: outputPath
        )
    }

    func readJSONFromFile(from path: String) throws -> [JSONDeclSyntax] {
        let fileURL = URL(fileURLWithPath: path)

        let jsonData = try Data(contentsOf: fileURL) // Read data from file
        let decoder = JSONDecoder()
        let anyJSON = try decoder.decode([AnyJSONDeclSyntax].self, from: jsonData)
        return anyJSON.compactMap(\.rawValue)
    }
}
