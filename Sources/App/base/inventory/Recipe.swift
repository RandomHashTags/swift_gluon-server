//
//  Recipe.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol Recipe : Jsonable {
    associatedtype TargetItemStack : ItemStack
    /// - Returns: The slot and material identifiers required to craft the result.
    var ingredients:[UInt:Set<String>] { get }
    
    /// - Returns: The ``ItemStack`` crafted by this recipe.
    var result:TargetItemStack { get }
}
