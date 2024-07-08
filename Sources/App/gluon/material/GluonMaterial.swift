//
//  GluonMaterial.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import SwiftStringCatalogs

struct GluonMaterial : Material {
    let id:String
    let name:LocalizedStringResource
    let categories:[any MaterialCategory]
    let configuration:any MaterialConfiguration
    
    let recipeID:String?
    var recipe : (any Recipe)? {
        guard let identifier:String = recipeID else { return nil }
        return GluonServer.shared.get_recipe(identifier: identifier)
    }
}
