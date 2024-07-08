//
//  MinecraftPlugin.swift
//  
//
//  Created by Evan Anderson on 7/7/24.
//


import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics

// @MinecraftPlugin(
//    bundle: String,
//    name: String,
//    description: String,
//    version: String,
//    authors: [String],
//    dependencies: [String]
//    commands: [MinecraftCommand.Type]
// )
struct MinecraftPlugin : MemberMacro {
    static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}

