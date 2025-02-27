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
    private var items: [PublicInterfaceEntry] = []

    private(set) var values: [JSONDeclSyntax] = []

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
        var parent: JSONParentDeclSyntax?
        if let value = node.as(ClassDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ClassJSONDeclSyntax(value)
        } else if let value = node.as(StructDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = StructJSONDeclSyntax(value)
        } else if let value = node.as(EnumDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = EnumJSONDeclSyntax(value)
        } else if let value = node.as(ActorDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ActorJSONDeclSyntax(value)
        } else if let value = node.as(ProtocolDeclSyntax.self), value.modifiers.isPublicOrOpen {
            parent = ProtocolJSONDeclSyntax(value)
        } else if let value = node.as(ExtensionDeclSyntax.self), value.modifiers.isPublicOrOpen || value.hasPublicMembers {
            parent = ExtensionJSONDeclSyntax(value)
        } else if let value = node.as(VariableDeclSyntax.self), value.modifiers.isPublicOrOpen {
            GlobalJSONDeclSyntax.shared.addChild(value)
        } else if let value = node.as(FunctionDeclSyntax.self), value.modifiers.isPublicOrOpen {
            GlobalJSONDeclSyntax.shared.addChild(value)
        }

        if let parent {
            let childrenVisitor = ChildrenVisitor(parent: parent)
            childrenVisitor.traverse()
            self.values.append(parent)
            return .skipChildren
        } else {
            return .visitChildren
        }
    }
}

protocol JSONDeclSyntax: CustomStringConvertible {}
protocol JSONParentDeclSyntax: AnyObject, JSONDeclSyntax {
    var children: [JSONDeclSyntax] { get set }
    var membersBlock: MemberBlockSyntax { get }

    func addChild(_ node: VariableDeclSyntax)
    func addChild(_ node: EnumCaseDeclSyntax)
    func addChild(_ node: FunctionDeclSyntax)
    func addChild(_ node: SubscriptDeclSyntax)
    func addChild(_ value: InitializerDeclSyntax)

    func addNestedParent(_ node: JSONParentDeclSyntax)
}

extension JSONParentDeclSyntax {
    var enumCases: [EnumCaseJSONDeclSyntax] { children.compactMap { $0 as? EnumCaseJSONDeclSyntax } }
    var variables: [VariableJSONDeclSyntax] { children.compactMap { $0 as? VariableJSONDeclSyntax } }
    var subscripts: [SubscriptJSONDeclSyntax] { children.compactMap { $0 as? SubscriptJSONDeclSyntax } }
    var initializers: [InitializerJSONDeclSyntax] { children.compactMap { $0 as? InitializerJSONDeclSyntax } }
    var functions: [FunctionJSONDeclSyntax] { children.compactMap { $0 as? FunctionJSONDeclSyntax } }
    var nested: [JSONParentDeclSyntax] { children.compactMap { $0 as? JSONParentDeclSyntax } }

    func addChild(_ node: VariableDeclSyntax) { children.append(VariableJSONDeclSyntax(node)) }
    func addChild(_ node: EnumCaseDeclSyntax) { children.append(EnumCaseJSONDeclSyntax(node)) }
    func addChild(_ node: FunctionDeclSyntax) { children.append(FunctionJSONDeclSyntax(node)) }
    func addChild(_ node: SubscriptDeclSyntax) { children.append(SubscriptJSONDeclSyntax(node)) }
    func addChild(_ node: InitializerDeclSyntax) { children.append(InitializerJSONDeclSyntax(node)) }

    func addNestedParent(_ node: JSONParentDeclSyntax) { children.append(node) }

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

final class GlobalJSONDeclSyntax: JSONParentDeclSyntax {
    var membersBlock: MemberBlockSyntax { .init(members: []) }

    nonisolated(unsafe) static let shared = GlobalJSONDeclSyntax()
    var children: [JSONDeclSyntax] = []
    private init() {}

    var description: String {
        var result = [String]()

        result.append("Global")

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class ClassJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: ClassDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: ClassDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.classKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class StructJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: StructDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: StructDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.structKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class EnumJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: EnumDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: EnumDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.enumKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class ActorJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: ActorDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: ActorDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.actorKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class ProtocolJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: ProtocolDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: ProtocolDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.protocolKeyword.text
        self.name = node.name.text
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

final class ExtensionJSONDeclSyntax: JSONParentDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var inheritance: [String]

    private let node: ExtensionDeclSyntax

    var children: [JSONDeclSyntax] = []
    var membersBlock: MemberBlockSyntax { node.memberBlock }

    init(_ node: ExtensionDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.extensionKeyword.text
        self.name = node.extendedType.description
        self.inheritance =
        node
            .inheritanceClause?
            .inheritedTypes
            .map(\.jsonDescription) ?? []
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        if !inheritance.isEmpty {
            result.append("\(type) \(name): \(inheritance.joined(separator: ", "))")
        } else {
            result.append("\(type) \(name)")
        }

        result.append(childrenDescription)

        return result.joined(separator: " ")
    }
}

struct VariableJSONDeclSyntax: JSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String

    private let node: VariableDeclSyntax

    init(_ node: VariableDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.type = node.bindingSpecifier.text
        self.name = node.bindings.cleanedUp.description
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append("\(type) \(name)")

        return result.joined(separator: " ")
    }
}

struct FunctionJSONDeclSyntax: JSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var name: String
    var signature: String

    private let node: FunctionDeclSyntax

    init(_ node: FunctionDeclSyntax) {
        self.node = node
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

struct InitializerJSONDeclSyntax: JSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var type: String
    var signature: String

    private let node: InitializerDeclSyntax

    init(_ node: InitializerDeclSyntax) {
        self.node = node
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

struct SubscriptJSONDeclSyntax: JSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var signature: String

    private let node: SubscriptDeclSyntax

    init(_ node: SubscriptDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.signature = node.cleanedUp.withoutTrivia.description
    }

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

struct EnumCaseJSONDeclSyntax: JSONDeclSyntax {
    var modifiers: [String]
    var attributes: [String]
    var name: String

    private let node: EnumCaseDeclSyntax

    init(_ node: EnumCaseDeclSyntax) {
        self.node = node
        self.modifiers = node
            .modifiers
            .map(\.jsonDescription)
        self.attributes = node
            .attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .map(\.jsonDescription)
        self.name = node.cleanedUp.description
    }

    var description: String {
        var result = [String]()

        if !attributes.isEmpty {
            result.append(attributes.joined(separator: " "))
        }

        if !modifiers.isEmpty {
            result.append(modifiers.joined(separator: " "))
        }

        result.append(name)

        return result.joined(separator: " ")
    }
}

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
