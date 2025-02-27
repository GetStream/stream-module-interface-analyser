//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import Foundation

final class ReportBuilder {

    private let storage: Storage
    private let queue = UnfairQueue()
    private var report: String?

    init(_ storage: Storage) {
        self.storage = storage
    }

    func writeReport(for source: URL, to outputURL: URL) throws {
        let content = buildReport(for: source)
        do {
            try content.write(
                to: outputURL,
                atomically: true,
                encoding: .utf8
            )
        } catch {
            print("Failed to write report at:\(outputURL) with error:\(error).")
        }
    }

    func logReport(for source: URL) {
        let content = buildReport(for: source)
        print(content)
    }

    // MARK: - Private Helpers

    private func buildReport(for source: URL) -> String {
        queue.sync {
            if let report = report {
                return report
            }

            let dictionary = storage.toDictionary()
            guard
                let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
                let jsonString = String(data: data, encoding: .utf8)
            else {
                return "No data available."
            }

            var content: [String] = []

            let header = """
            === \(source.lastPathComponent) Public API - Begin (Containers: \(storage.endIndex)) ===
            
            """

            content.append(jsonString)

            let footer = """
            
            === \(source.lastPathComponent) Public API - End === 
            """

            let result = [
                header,
                content.joined(),
                footer
            ].joined()
            self.report = result
            return result
        }
    }
}
