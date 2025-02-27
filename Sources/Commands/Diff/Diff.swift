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
        let files: [String] = [fileA, fileB]
            .map { URL(fileURLWithPath: $0).resolvingSymlinksInPath().path }

        guard files.count == 2 else {
            throw "Invalid input files"
        }

        let analyser = DiffAnalyzer()
        await analyser.analyzeDiff(
            file1Path: files[0],
            file2Path: files[1],
            outputFilePath: outputPath
        )
    }
}
