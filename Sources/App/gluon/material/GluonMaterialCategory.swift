//
//  GluonMaterialCategory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialCategory : MaterialCategory {
    typealias TargetMaterialConfiguration = GluonMaterialConfiguration
    
    let identifier:String
    let configuration:TargetMaterialConfiguration
}
