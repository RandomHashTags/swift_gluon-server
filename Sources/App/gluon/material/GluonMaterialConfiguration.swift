//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonMaterialConfiguration : MaterialConfiguration {
    public typealias TargetMaterialItemConfiguration = GluonMaterialItemConfiguration
    public typealias TargetMaterialBlockConfiguration = GluonMaterialBlockConfiguration
    
    public let item:TargetMaterialItemConfiguration?
    public let block:TargetMaterialBlockConfiguration?
}
