//
//  FunctionJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct FunctionJSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var signature: String
}

extension FunctionJSONDeclSyntax: JSONDeclSyntax {

    init(_ node: FunctionDeclSyntax) {
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.funcKeyword.text
        self.name = node.name.text
        self.signature = node.signature.cleanedUp.description
    }

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .function,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            name: name,
            signature: signature
        )
    }
}

extension FunctionJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append("\(type) \(name)\(signature)")

        return result.joined(separator: " ")
    }
}
