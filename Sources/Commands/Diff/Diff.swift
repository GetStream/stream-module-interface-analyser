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

struct Diff: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Compare two reports and create a diff visualisation."
    )

    @Argument(help: "The url pointing to the first report.")
    var fileA: String

    @Argument(help: "The url pointing to the second report.")
    var fileB: String

    @Argument(help: "The output path where the markdown file will be created.")
    var outputPath: String

    func run() throws {
        let files = [fileA, fileB]
            .map { URL(fileURLWithPath: $0).resolvingSymlinksInPath().path }
            .joined(separator: " ")

        guard
            let scriptURL = Bundle.module.url(forResource: "diff", withExtension: "sh")?.path,
            let diffScript = Bundle.module.url(forResource: "diff-script", withExtension: "js")?.path
        else {
            throw "Unable to find the diffing script."
        }

        runShellCommand("\(scriptURL) \(diffScript) \(files) \(URL(fileURLWithPath: outputPath).path)")
    }

    /// Helper function to run shell commands
    func runShellCommand(_ command: String) {
        let process = Process()
        process.launchPath = "/bin/bash"
        process.arguments = ["-c", command]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        process.launch()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            print(output)
        }

        if process.terminationStatus != 0 {
            fatalError("❌ Command failed: \(command)")
        }
    }
}
