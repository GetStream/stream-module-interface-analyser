//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import ArgumentParser

@main
struct MainConmmand: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift CLI tool to analyse the open and public APIs.",
        subcommands: [Analysis.self, Diff.self],
        defaultSubcommand: Analysis.self
    )
}
