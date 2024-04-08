//
//  GluonMaterial.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterial : Material {
    let id:String
    let name:String
    let categories:[any MaterialCategory]
    let configuration:any MaterialConfiguration
    
    let recipe_id:String?
    var recipe : (any Recipe)? {
        guard let identifier:String = recipe_id else { return nil }
        return GluonServer.shared.get_recipe(identifier: identifier)
    }
}
