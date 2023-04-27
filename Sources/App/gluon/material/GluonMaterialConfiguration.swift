//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialConfiguration : MaterialConfiguration {
    typealias TargetMaterialItemConfiguration = GluonMaterialItemConfiguration
    typealias TargetMaterialBlockConfiguration = GluonMaterialBlockConfiguration
    
    let item:TargetMaterialItemConfiguration?
    let block:TargetMaterialBlockConfiguration?
}
