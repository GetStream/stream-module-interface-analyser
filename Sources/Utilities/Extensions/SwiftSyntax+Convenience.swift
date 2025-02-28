//
//  SwiftSyntax+Convenience.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation
import SwiftSyntax

extension DeclModifierSyntax {
    var jsonDescription: String {
        return name.text
    }
}

extension AttributeSyntax {
    var jsonDescription: String {
        withoutTrivia.description
    }
}

extension InheritedTypeSyntax {
    var withoutTrailingComma: Self {
        var mutable = self
        mutable.trailingComma = nil
        return mutable
    }

    var jsonDescription: String {
        withoutTrivia
            .withoutTrailingComma
            .description
    }
}

extension SyntaxProtocol {
    var withoutTrivia: Self {
        var mutable = self
        mutable.leadingTrivia = leadingTrivia.cleanedUp
        mutable.trailingTrivia = trailingTrivia.cleanedUp
        return mutable
    }
}

extension PatternBindingSyntax {
    var withoutAccessor: Self {
        var mutable = self
        mutable.accessorBlock = nil
        return mutable
    }

    var withoutInitializer: Self {
        var mutable = self
        mutable.initializer = nil
        return mutable
    }
}

extension SubscriptDeclSyntax {
    var withoutAccessor: Self {
        var mutable = self
        mutable.accessorBlock = nil
        return mutable
    }

    var cleanedUp: Self {
        var mutable = self.withoutAccessor
        mutable.parameterClause.leftParen = mutable.parameterClause.leftParen.withoutTrivia
        mutable.parameterClause.parameters = .init(mutable.parameterClause.parameters.map(\.withoutTrivia))
        mutable.parameterClause.rightParen = mutable.parameterClause.rightParen.withoutTrivia
        mutable.attributes = []
        mutable.modifiers = []
        return mutable
    }
}

extension EnumCaseDeclSyntax {
    var cleanedUp: Self {
        var mutable = self.withoutTrivia
        mutable.attributes = []
        mutable.modifiers = []
        return mutable
    }
}

extension FunctionSignatureSyntax {
    var cleanedUp: Self {
        var mutable = self
        mutable.parameterClause.leftParen = mutable.parameterClause.leftParen.withoutTrivia
        mutable.parameterClause.parameters = .init(mutable.parameterClause.parameters.map(\.withoutTrivia))
        mutable.parameterClause.rightParen = mutable.parameterClause.rightParen.withoutTrivia
        mutable.returnClause = mutable.returnClause?.withoutTrivia
        return mutable
    }
}

extension PatternBindingListSyntax {
    var cleanedUp: Self {
        .init(self.map(\.withoutAccessor.withoutInitializer.withoutTrivia))
    }
}

extension Trivia {
    var withoutLineComment: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .lineComment:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var withoutBlockComment: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .blockComment:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var withoutDocLineComment: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .docLineComment:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var withoutDocBlockComment: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .docBlockComment:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var withoutNewLines: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .newlines:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var withoutSpaces: Self {
        var mutable = self
        mutable = Trivia(
            pieces: mutable
                .pieces
                .filter {
                    switch $0 {
                    case .spaces:
                        return false
                    default:
                        return true
                    }
                }
        )
        return mutable
    }

    var cleanedUp: Self {
        withoutLineComment
            .withoutBlockComment
            .withoutDocLineComment
            .withoutDocBlockComment
            .withoutNewLines
            .withoutSpaces
    }
}

extension DeclModifierListSyntax {
    var isPublicOrOpen: Bool {
        contains([.public, .open])
    }

    func contains(
        _ values: [Keyword]
    ) -> Bool {
        var found: [Bool] = []
        values.forEach { value in
            found.append(self.first { $0.name.tokenKind == .keyword(value) } != nil)
        }
        let result = found.contains { $0 == true }
        return result
    }
}

extension ExtensionDeclSyntax {

    var hasPublicMembers: Bool {
        (memberBlock
            .members
            .lazy
            .first { member in
                if let decl = member.decl.as(VariableDeclSyntax.self) {
                    return decl.modifiers.isPublicOrOpen
                } else if let decl = member.decl.as(FunctionDeclSyntax.self) {
                    return decl.modifiers.isPublicOrOpen
                } else {
                    return false
                }
            } != nil)
    }
}
