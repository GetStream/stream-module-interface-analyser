//
//  SubscriptJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct SubscriptJSONDeclSyntax{
    var modifiers: [String]
    var attributes: [String]
    var signature: String
}

extension SubscriptJSONDeclSyntax: JSONDeclSyntax {

    init(_ node: SubscriptDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.signature = node.cleanedUp.withoutTrivia.description
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .subscript,
            modifiers: modifiers,
            attributes: attributes,
            signature: signature
        )
    }
}

extension SubscriptJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append(signature)

        return result.joined(separator: " ")
    }
}
