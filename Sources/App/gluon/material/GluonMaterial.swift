//
//  GluonMaterial.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterial : Material {
    typealias TargetMaterialCategory = GluonMaterialCategory
    typealias TargetMaterialConfiguration = GluonMaterialConfiguration
    typealias TargetRecipe = GluonRecipe
    
    let identifier:String
    let name:MultilingualStrings
    let categories:[TargetMaterialCategory]
    let configuration:TargetMaterialConfiguration
    
    let recipe_identifier:String?
    var recipe : TargetRecipe? {
        guard let identifier:String = recipe_identifier else { return nil }
        return GluonServer.shared_instance.get_recipe(identifier: identifier)
    }
}
