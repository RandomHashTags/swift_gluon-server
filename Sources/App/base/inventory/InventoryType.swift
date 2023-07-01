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
    /// Whitelisted slots where specific ``MaterialCategory`` ids can only be placed at, if applicable.
    var material_category_restrictions : [UInt:Set<String>]? { get }
    /// Whitelisted slots where specific ``Material`` ids can only be placed at, if applicable.
    var material_retrictions : [UInt:Set<String>]? { get }
    /// The allowed ``Recipe`` ids that can be created when inside this inventory type, if applicable.
    var allowed_recipe_ids : Set<String>? { get }
    /// The allowed ``Recipe``s that can be created when inside this inventory type, if applicable.
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
