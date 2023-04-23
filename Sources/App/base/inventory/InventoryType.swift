//
//  InventoryType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct InventoryType : Jsonable {
    public let identifier:String
    public let categories:[String]
    /// Maximum amount of slots this inventory type contains.
    public let size:UInt
    /// Whitelisted slots that only allow specific materials that belong to specific material categories
    public let material_category_restrictions:[UInt:Set<String>]?
    /// Whitelisted slots that only allow specific material identifiers.
    public let material_retrictions:[UInt:Set<String>]?
    /// The allowed Recipe identifiers that can be created when inside this inventory type.
    public let allowed_recipe_identifiers:Set<String>?
}
public extension InventoryType {
    /// The allowed Recipes that can be created when inside this inventory type.
    var allowed_recipes : Set<Recipe>? {
        guard let identifiers:Set<String> = allowed_recipe_identifiers else { return nil }
        return GluonServer.get_recipes(identifiers: identifiers)
    }
}
