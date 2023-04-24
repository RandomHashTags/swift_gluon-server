//
//  GluonMaterialCategory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonMaterialCategory : MaterialCategory {
    public typealias TargetMaterialConfiguration = GluonMaterialConfiguration
    
    public let identifier:String
    public let configuration:TargetMaterialConfiguration
}
