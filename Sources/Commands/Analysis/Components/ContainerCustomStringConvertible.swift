//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import SwiftSyntax

struct ContainerCustomStringConvertible: CustomStringConvertible {

    var node: ContainerDeclSyntax?
    var depth: Int
    var members: [PublicInterfaceEntry]

    var definition: String {
        if let node {
            let attributes = node
                .attributes
                .map { Syntax($0).stripLeadingOrTrailingComments().description }

            let modifiers = node
                .modifiers
                .map(\.name.text.description)

            let inheritanceClause = {
                guard let value = node.inheritanceClause else {
                    return ""
                }
                var result = value
                    .inheritedTypes
                    .map(\.type.description)
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .joined(separator: ", ")

                if !result.isEmpty {
                    result = ": \(result)"
                }

                return result
            }()

            let result = [
                attributes,
                modifiers,
                [node.typeAsString()],
                [node.nameString],
                [inheritanceClause]
            ]
            .flatMap { $0 }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")

            return (depth == 0 ? "\n\n" : "") + String(repeating: "\t", count: depth) + result
        } else {
            return (depth == 0 ? "\n\n" : "") + String(repeating: "\t", count: depth) + "Global"
        }
    }

    var key: String {
        if let node {
            let attributes = node
                .attributes
                .map { Syntax($0).stripLeadingOrTrailingComments().description }

            let modifiers = node
                .modifiers
                .map(\.name.text.description)

            let inheritanceClause = {
                guard let value = node.inheritanceClause else {
                    return ""
                }
                var result = value
                    .inheritedTypes
                    .map(\.type.description)
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .joined(separator: ", ")

                if !result.isEmpty {
                    result = ": \(result)"
                }

                return result
            }()

            let result = [
                attributes,
                modifiers,
                [node.typeAsString()],
                [node.nameString],
                [inheritanceClause]
            ]
            .flatMap { $0 }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")

            return String(repeating: "\t", count: depth) + result
        } else {
            return String(repeating: "\t", count: depth) + "Global"
        }
    }

    private var membersDescription: String {
        var result: [String] = []

        for member in members {
            switch member {
            case let .container(node, depth, members):
                let description = ContainerCustomStringConvertible(
                    node: node,
                    depth: depth,
                    members: members
                ).description

                result.append(description)

            case let .variable(node, depth):
                result.append(node.definition(depth: depth))

            case let .enumCase(node, depth):
                result.append(node.definition(depth: depth))

            case let .function(node, depth):
                result.append(node.definition(depth: depth))

            case let .subscript(node, depth):
                return node.definition(depth: depth)

            case let .initialiser(node, depth):
                result.append(node.definition(depth: depth))
            }
        }

        return result.joined(separator: "\n")
    }

    private var membersDictionary: [Any] {
        var result: [Any] = []

        for member in members {
            switch member {
            case let .container(node, _, members):
                let dictionary = ContainerCustomStringConvertible(
                    node: node,
                    depth: 0,
                    members: members
                ).dictionary

                result.append(dictionary)

            case let .variable(node, _):
                result.append(node.definition(depth: 0))

            case let .enumCase(node, _):
                result.append(node.definition(depth: 0))

            case let .function(node, _):
                result.append(node.definition(depth: 0))

            case let .subscript(node, _):
                result.append(node.definition(depth: 0))

            case let .initialiser(node, _):
                result.append(node.definition(depth: 0))
            }
        }

        return result
    }

    var description: String {
        [definition, membersDescription].joined(separator: "\n")
    }

    var dictionary: [String: Any] {
        return [
            key: membersDictionary
        ]
    }
}
