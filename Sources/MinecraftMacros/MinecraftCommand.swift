//
//  MinecraftCommand.swift
//  
//
//  Created by Evan Anderson on 7/7/24.
//


import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics

// @MinecraftCommand(
//    id: String,
//    permission: String?,
//    aliases: [String],
//    description: String
// )
struct MinecraftCommand : MemberMacro {
    static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}