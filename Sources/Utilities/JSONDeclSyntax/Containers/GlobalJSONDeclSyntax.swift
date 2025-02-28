//
//  GlobalJSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

struct GlobalJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String] = []
    var attributes: [String] = []
    var type: String = "global-container"
    var name: String = "Global"
    var inheritance: [String] = []
    var children: [JSONDeclSyntax] = []

    nonisolated(unsafe) static var shared = GlobalJSONDeclSyntax()

    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax {
        .init(
            contentType: .global,
            modifiers: modifiers,
            attributes: attributes,
            type: type,
            name: name,
            inheritance: inheritance,
            children: children.map { $0.eraseToAnyJSONDeclSyntax() }
        )
    }
}

extension GlobalJSONDeclSyntax: CustomStringConvertible {

    var description: String {
        var result = [String]()

        result.append(name)

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}
