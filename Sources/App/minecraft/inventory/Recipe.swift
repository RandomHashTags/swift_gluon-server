//
//  Recipe.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public struct Recipe : Identifiable, Hashable {
    public let id:String
    /// - Returns: The slot and material identifiers required to craft the result.
    public let ingredients:[UInt:Set<String>]

    /// - Returns: The ``RecipeResult`` id crafted by this recipe.
    public let resultID:String?
}