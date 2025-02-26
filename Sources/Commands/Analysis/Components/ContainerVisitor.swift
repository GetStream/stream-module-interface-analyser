//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import Foundation
import SwiftParser
import SwiftSyntax

/// Visitor to traverse Swift syntax and extract public entities.
final class ContainerVisitor: SyntaxVisitor {
    private let url: URL
    private let source: String
    private var items: [PublicInterfaceEntry] = []

    private(set) var globalItems: [PublicInterfaceEntry] = []

    init(_ fileURL: URL) throws {
        url = fileURL
        source = try String(contentsOf: fileURL, encoding: .utf8)
        super.init(viewMode: .all)
    }

    // MARK: Traverse

    func traverse() -> [PublicInterfaceEntry] {
        let sourceFile = Parser.parse(source: source)
        walk(sourceFile)
        return items
    }

    // MARK: - SyntaxVisitor

    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        visitContainerNode(node)
    }

    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        visitContainerNode(node)
    }

    override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        visitContainerNode(node)
    }

    override func visit(_ node: ActorDeclSyntax) -> SyntaxVisitorContinueKind {
        visitContainerNode(node)
    }

    override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        visitContainerNode(node)
    }

    override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
        let hasPublicMembers = node.memberBlock.members.contains { member in
            if let decl = member.decl.as(VariableDeclSyntax.self) {
                return decl.modifiers.isPublicOrOpen
            } else if let decl = member.decl.as(FunctionDeclSyntax.self) {
                return decl.modifiers.isPublicOrOpen
            }
            return false
        }

        guard
            node.modifiers.isPublicOrOpen || hasPublicMembers
        else {
            return .skipChildren
        }

        return visitContainerNode(node)
    }

    // MARK: - Global variables and functions

    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        if node.modifiers.isPublicOrOpen {
            globalItems.append(.variable(node.removingInitializer(), 0))
        }
        return .skipChildren
    }

    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        if node.modifiers.isPublicOrOpen {
            globalItems.append(.function(node.removeTrivia().removeBody(), 0))
        }

        return .skipChildren
    }

    // MARK: - Private Helpers

    private func visitContainerNode(
        _ node: DeclSyntaxProtocol
    ) -> SyntaxVisitorContinueKind {
        guard
            let container = node as? ContainerDeclSyntax,
            container.modifiers.isPublicOrOpen || node.is(ExtensionDeclSyntax.self)
        else {
            return .skipChildren
        }

        let newVisitor = VariableAndFunctionsVisitor(
            parent: container,
            depth: 1,
            publicOnly: !(node.is(ExtensionDeclSyntax.self) || node.is(ProtocolDeclSyntax.self))
        )
        let children = newVisitor.traverse()
        items.append(.container(container, 0, children))

        return .skipChildren
    }
}
