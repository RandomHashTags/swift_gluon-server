//
//  GluonInventoryType.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonInventoryType : InventoryType {
    public typealias TargetRecipe = GluonRecipe
    
    public let identifier:String
    public let categories:[String]
    public let size:UInt
    public let material_category_restrictions:[UInt:Set<String>]?
    public let material_retrictions:[UInt:Set<String>]?
    public let allowed_recipe_identifiers:Set<String>?
    public var allowed_recipes : Set<TargetRecipe>? {
        guard let identifiers:Set<String> = allowed_recipe_identifiers else { return nil }
        return GluonServer.shared_instance.get_recipes(identifiers: identifiers)
    }
}
