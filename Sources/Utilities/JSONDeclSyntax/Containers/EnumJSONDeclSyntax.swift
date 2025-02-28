//
//  EnumJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct EnumJSONDeclSyntax{
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]
    var children: [JSONDeclSyntax] = []
}

extension EnumJSONDeclSyntax: JSONParentDeclSyntax {

    init(_ node: EnumDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.enumKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .enum,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            name: name,
            inheritance: inheritance,
            children: children.map { $0.eraseToAnyJSONDeclSyntax() }
        )
    }
}

extension EnumJSONDeclSyntax: CustomStringConvertible {

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
