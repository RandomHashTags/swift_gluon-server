//
//  GluonMaterialCategory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialCategory : MaterialCategory {
    let id:String
    let configuration_id:String
    var configuration : (any MaterialConfiguration)? {
        return nil // TODO: fix
    }
}
