//
//  GluonInventoryType.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonInventoryType : InventoryType {
    typealias TargetRecipe = GluonRecipe
    
    let identifier:String
    let categories:[String]
    let size:UInt
    let material_category_restrictions:[UInt:Set<String>]?
    let material_retrictions:[UInt:Set<String>]?
    let allowed_recipe_identifiers:Set<String>?
    var allowed_recipes : Set<TargetRecipe>? {
        guard let identifiers:Set<String> = allowed_recipe_identifiers else { return nil }
        return GluonServer.shared_instance.get_recipes(identifiers: identifiers)
    }
}
