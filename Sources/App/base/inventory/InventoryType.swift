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
    /// The allowed Recipes to be created in this inventory type.
    public let recipes:Set<Recipe>?
}
