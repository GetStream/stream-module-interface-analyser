//
//  VariableJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct VariableJSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
}

extension VariableJSONDeclSyntax: JSONDeclSyntax {

    init(_ node: VariableDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.bindingSpecifier.text
        self.name = node.bindings.cleanedUp.description
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .variable,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            name: name
        )
    }
}

extension VariableJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append("\(type) \(name)")

        return result.joined(separator: " ")
    }
}
