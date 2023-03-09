//
//  Recipe.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public struct Recipe : Jsonable {
    /// - Returns: The slot and material identifiers required to craft the result.
    public let ingredients:[UInt:Set<String>]
    
    /// - Returns: The ``ItemStack`` crafted by this recipe.
    public let result:ItemStack
}
