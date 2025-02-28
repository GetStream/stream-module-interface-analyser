//
//  RawJSONDeclRepresentation.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation

struct AnyJSONDeclSyntax: Codable, Equatable, Hashable {

    enum ContentType: String, Codable {
        case `actor`, `class`, `enum`, `extension`, global, `protocol`, `struct`
        case enumCase, function, initializer, `subscript`, variable
    }

    var contentType: ContentType
    var modifiers: [String]?
    var attributes: [String]?
    var type: String?
    var name: String?
    var signature: String?
    var inheritance: [String]?
    var children: [AnyJSONDeclSyntax]?
}

extension AnyJSONDeclSyntax {

    var rawValue: (JSONDeclSyntax)? {
        switch self.contentType {
        case .actor:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return ActorJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .class:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return ClassJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .enum:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return EnumJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .extension:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return ExtensionJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .global:
            GlobalJSONDeclSyntax.shared.children = (children ?? []).compactMap { $0.rawValue }
            return GlobalJSONDeclSyntax.shared

        case .protocol:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return ProtocolJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .struct:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let inheritance
            else {
                return nil
            }
            return StructJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                inheritance: inheritance,
                children: (children ?? []).compactMap { $0.rawValue }
            )

        case .enumCase:
            guard
                let modifiers,
                let attributes,
                let name
            else {
                return nil
            }
            return EnumCaseJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                name: name
            )

        case .function:
            guard
                let modifiers,
                let attributes,
                let type,
                let name,
                let signature
            else {
                return nil
            }
            return FunctionJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name,
                signature: signature
            )

        case .initializer:
            guard
                let modifiers,
                let attributes,
                let type,
                let signature
            else {
                return nil
            }
            return InitializerJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                signature: signature
            )

        case .subscript:
            guard
                let modifiers,
                let attributes,
                let signature
            else {
                return nil
            }
            return SubscriptJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                signature: signature
            )

        case .variable:
            guard
                let modifiers,
                let attributes,
                let type,
                let name
            else {
                return nil
            }
            return VariableJSONDeclSyntax(
                modifiers: modifiers,
                attributes: attributes,
                type: type,
                name: name
            )
        }
    }
}
