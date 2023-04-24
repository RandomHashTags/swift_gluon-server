//
//  InventoryType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol InventoryType : Jsonable, Identifiable {
    associatedtype TargetRecipe : Recipe
    
    var categories : [String] { get }
    /// Maximum amount of slots this inventory type contains.
    var size : UInt { get }
    /// Whitelisted slots that only allow specific materials that belong to specific material categories
    var material_category_restrictions : [UInt:Set<String>]? { get }
    /// Whitelisted slots that only allow specific material identifiers.
    var material_retrictions : [UInt:Set<String>]? { get }
    /// The allowed Recipe identifiers that can be created when inside this inventory type.
    var allowed_recipe_identifiers : Set<String>? { get }
    /// The allowed Recipes that can be created when inside this inventory type.
    var allowed_recipes : Set<TargetRecipe>? { get }
}
