//
//  EnumCaseJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct EnumCaseJSONDeclSyntax: Codable {
    var modifiers: [String]
    var attributes: [String]
    var name: String
}

extension EnumCaseJSONDeclSyntax: JSONDeclSyntax {

    init(_ node: EnumCaseDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.name = node.cleanedUp.description
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .enumCase,
            modifiers: modifiers,
            attributes: attributes,
            name: name
        )
    }
}

extension EnumCaseJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append(name)

        return result.joined(separator: " ")
    }
}
