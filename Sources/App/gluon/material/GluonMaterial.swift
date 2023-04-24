//
//  GluonMaterial.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonMaterial : Material {
    public typealias TargetMaterialCategory = GluonMaterialCategory
    public typealias TargetMaterialConfiguration = GluonMaterialConfiguration
    public typealias TargetRecipe = GluonRecipe
    
    public let identifier:String
    public let name:MultilingualStrings
    public let categories:[TargetMaterialCategory]
    public let configuration:TargetMaterialConfiguration
    
    public let recipe_identifier:String?
    public var recipe : TargetRecipe? {
        guard let identifier:String = recipe_identifier else { return nil }
        return GluonServer.shared_instance.get_recipe(identifier: identifier)
    }
}
