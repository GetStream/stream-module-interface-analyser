//
//  ExtensionJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct ExtensionJSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]
    var children: [JSONDeclSyntax] = []
}

extension ExtensionJSONDeclSyntax: JSONParentDeclSyntax {

    init(_ node: ExtensionDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.extensionKeyword.text
        self.name = node.extendedType.description.trimmingCharacters(in: .whitespacesAndNewlines)
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .extension,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            name: name,
            inheritance: inheritance,
            children: children.map { $0.eraseToAnyJSONDeclSyntax() }
        )
    }
}

extension ExtensionJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}
