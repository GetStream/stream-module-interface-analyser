//
// Copyright © 2025 Stream.io Inc. All rights reserved.
//

import SwiftSyntax

final class ChildrenVisitor: SyntaxVisitor {

    private var parent: any JSONParentDeclSyntax
    private let membersBlock: MemberBlockSyntax?

    init(
        parent: any JSONParentDeclSyntax,
        membersBlock: MemberBlockSyntax?,
        viewMode: SyntaxTreeViewMode = .all
    ) {
        self.parent = parent
        self.membersBlock = membersBlock
        super.init(viewMode: viewMode)
    }

    func traverse() -> any JSONParentDeclSyntax {
        if let membersBlock {
            super.walk(membersBlock)
        }
        return parent
    }

    // MARK: - Container

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

    // MARK: - Children

    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
        process(node)
    }

    // MARK: - Private Helpers

    private func process(_ node: SyntaxProtocol) -> SyntaxVisitorContinueKind {
        var nestedParent: (any JSONParentDeclSyntax)?
        var membersBlock: MemberBlockSyntax?
        if let value = node.as(ClassDeclSyntax.self), value.modifiers.isPublicOrOpen {
            nestedParent = ClassJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(StructDeclSyntax.self), value.modifiers.isPublicOrOpen {
            nestedParent = StructJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(EnumDeclSyntax.self), value.modifiers.isPublicOrOpen {
            nestedParent = EnumJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ActorDeclSyntax.self), value.modifiers.isPublicOrOpen {
            nestedParent = ActorJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ProtocolDeclSyntax.self), value.modifiers.isPublicOrOpen {
            nestedParent = ProtocolJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(ExtensionDeclSyntax.self), value.modifiers.isPublicOrOpen || value.hasPublicMembers {
            nestedParent = ExtensionJSONDeclSyntax(value)
            membersBlock = value.memberBlock
        } else if let value = node.as(VariableDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent.addChild(value)
        } else if let value = node.as(EnumCaseDeclSyntax.self) {
            parent.addChild(value)
        } else if let value = node.as(FunctionDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent.addChild(value)
        } else if let value = node.as(SubscriptDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent.addChild(value)
        } else if let value = node.as(InitializerDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent.addChild(value)
        }

        if let nestedParent {
            let childrenVisitor = ChildrenVisitor(parent: nestedParent, membersBlock: membersBlock)
            let updatedParent = childrenVisitor.traverse()
            parent.addNestedParent(updatedParent)
            return .skipChildren
        } else {
            return .visitChildren
        }
    }
}
