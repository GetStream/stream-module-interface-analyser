//
//  InitializerJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct InitializerJSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var signature: String
}

extension InitializerJSONDeclSyntax: JSONDeclSyntax {

    init(_ node: InitializerDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.initKeyword.text
        self.signature = node.signature.cleanedUp.description
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .initializer,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            signature: signature
        )
    }
}

extension InitializerJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append("\(type)\(signature)")

        return result.joined(separator: " ")
    }
}
