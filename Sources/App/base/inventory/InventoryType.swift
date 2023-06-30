//
//  InventoryType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol InventoryType : Hashable, Identifiable where ID == String {
    var categories : [String] { get }
    /// Maximum amount of slots this inventory type contains.
    var size : UInt { get }
    /// Whitelisted slots that only allow specific materials that belong to specific material categories
    var material_category_restrictions : [UInt:Set<String>]? { get }
    /// Whitelisted slots that only allow specific material identifiers, if applicable.
    var material_retrictions : [UInt:Set<String>]? { get }
    /// The allowed Recipe identifiers that can be created when inside this inventory type, if applicable.
    var allowed_recipe_identifiers : Set<String>? { get }
    /// The allowed Recipes that can be created when inside this inventory type, if applicable.
    var allowed_recipes : [any Recipe]? { get }
}

public extension InventoryType {
    static func == (left: any InventoryType, right: any InventoryType) -> Bool {
        return left.id.elementsEqual(right.id)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
