//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import Foundation
import SwiftParser
import SwiftSyntax

/// Visitor to traverse Swift syntax and extract public entities.
final class SourceFileVisitor: SyntaxVisitor {
    private let url: URL
    private let source: String
    private var items: [JSONDeclSyntax] = []

    init(_ fileURL: URL) throws {
        url = fileURL
        source = try String(contentsOf: fileURL, encoding: .utf8)
        super.init(viewMode: .all)
    }

    // MARK: Traverse

    func traverse() -> [JSONDeclSyntax] {
        let sourceFile = Parser.parse(source: source)
        walk(sourceFile)
        return items
    }

    // MARK: - SyntaxVisitor

    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: ActorDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    // MARK: - Global variables and functions

    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    // MARK: - Private Helpers

    private func process(_ node: SyntaxProtocol) -> SyntaxVisitorContinueKind {
        var parent: (any JSONParentDeclSyntax)?
        var membersBlock: MemberBlockSyntax?
        if let value = node.as(ClassDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ClassJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(StructDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = StructJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(EnumDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = EnumJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ActorDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ActorJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ProtocolDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ProtocolJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ExtensionDeclSyntax.self), value.modifiers.isPublicOrOpen || value.hasPublicMembers {
            parent = ExtensionJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(VariableDeclSyntax.self), value.modifiers.isPublicOrOpen {
            GlobalJSONDeclSyntax.shared.addChild(value)
        } else if let value = node.as(FunctionDeclSyntax.self), value.modifiers.isPublicOrOpen {
            GlobalJSONDeclSyntax.shared.addChild(value)
        }

        if let parent {
            let childrenVisitor = ChildrenVisitor(parent: parent, membersBlock: membersBlock)
            let updatedParent = childrenVisitor.traverse()
            items.append(updatedParent)
            return .skipChildren
        } else {
            return .visitChildren
        }
    }
}


























