//
//  JSONDeclSyntax.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

protocol JSONDeclSyntax: CustomStringConvertible {
    func eraseToAnyJSONDeclSyntax() -> AnyJSONDeclSyntax
}

protocol JSONParentDeclSyntax: JSONDeclSyntax {
    var modifiers: [String] { get set }
    var attributes: [String] { get set }
    var type: String { get set }
    var name: String { get set }
    var inheritance: [String] { get set }

    var children: [JSONDeclSyntax] { get set }

    mutating func addChild(_ node: VariableDeclSyntax)
    mutating func addChild(_ node: EnumCaseDeclSyntax)
    mutating func addChild(_ node: FunctionDeclSyntax)
    mutating func addChild(_ node: SubscriptDeclSyntax)
    mutating func addChild(_ value: InitializerDeclSyntax)

    mutating func addNestedParent(_ node: any JSONParentDeclSyntax)
}

extension JSONParentDeclSyntax {
    var enumCases: [EnumCaseJSONDeclSyntax] { children.compactMap { $0 as? EnumCaseJSONDeclSyntax } }
    var variables: [VariableJSONDeclSyntax] { children.compactMap { $0 as? VariableJSONDeclSyntax } }
    var subscripts: [SubscriptJSONDeclSyntax] { children.compactMap { $0 as? SubscriptJSONDeclSyntax } }
    var initializers: [InitializerJSONDeclSyntax] { children.compactMap { $0 as? InitializerJSONDeclSyntax } }
    var functions: [FunctionJSONDeclSyntax] { children.compactMap { $0 as? FunctionJSONDeclSyntax } }
    var nested: [any JSONParentDeclSyntax] { children.compactMap { $0 as? (any JSONParentDeclSyntax) } }

    mutating func addChild(_ node: VariableDeclSyntax) { children.append(VariableJSONDeclSyntax(node)) }
    mutating func addChild(_ node: EnumCaseDeclSyntax) { children.append(EnumCaseJSONDeclSyntax(node)) }
    mutating func addChild(_ node: FunctionDeclSyntax) { children.append(FunctionJSONDeclSyntax(node)) }
    mutating func addChild(_ node: SubscriptDeclSyntax) { children.append(SubscriptJSONDeclSyntax(node)) }
    mutating func addChild(_ node: InitializerDeclSyntax) { children.append(InitializerJSONDeclSyntax(node)) }

    mutating func addNestedParent(_ node: any JSONParentDeclSyntax) { children.append(node) }

    var childrenDescription: String {
        var result = ["\n"]

        let enumCases = enumCases.map(\.description)
        if !enumCases.isEmpty {
            result.append(contentsOf: enumCases)
            result.append("\n")
        }

        let variables = variables.map(\.description)
        if !variables.isEmpty {
            result.append(contentsOf: variables)
            result.append("\n")
        }

        let subscripts = subscripts.map(\.description)
        if !subscripts.isEmpty {
            result.append(contentsOf: subscripts)
            result.append("\n")
        }

        let initializers = initializers.map(\.description)
        if !initializers.isEmpty {
            result.append(contentsOf: initializers)
            result.append("\n")
        }

        let functions = functions.map(\.description)
        if !functions.isEmpty {
            result.append(contentsOf: functions)
            result.append("\n")
        }

        let nested = nested.map { $0.description.replacingOccurrences(of: "\n", with: "\n  ") }
        if !nested.isEmpty {
            result.append(contentsOf: nested)
            result.append("\n")
        }

        return result
            .map { " \($0)" }
            .joined(separator: "\n ")
    }
}
