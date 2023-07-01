//
//  GluonInventoryType.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonInventoryType : InventoryType {
    let id:String
    let categories:[String]
    let size:UInt
    let material_category_restrictions:[UInt:Set<String>]?
    let material_retrictions:[UInt:Set<String>]?
    let allowed_recipe_ids:Set<String>?
    var allowed_recipes : [any Recipe]? {
        guard let identifiers:Set<String> = allowed_recipe_ids else { return nil }
        return GluonServer.shared_instance.get_recipes(identifiers: identifiers)
    }
}
