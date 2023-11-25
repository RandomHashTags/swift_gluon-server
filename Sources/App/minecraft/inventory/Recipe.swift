//
//  Recipe.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol Recipe {
    /// - Returns: The slot and material identifiers required to craft the result.
    var ingredients : [UInt:Set<String>] { get }
    
    /// - Returns: The ``RecipeResult`` id crafted by this recipe.
    var result_id : String { get }
    var result : (any RecipeResult)? { get }
}
