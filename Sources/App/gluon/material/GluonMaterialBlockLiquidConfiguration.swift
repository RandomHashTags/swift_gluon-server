//
//  GluonMaterialBlockLiquidConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

final class GluonMaterialBlockLiquidConfiguration : MaterialBlockLiquidConfiguration {
    var distances_per_tick:[String:Double]
    
    init(distances_per_tick: [String:Double]) {
        self.distances_per_tick = distances_per_tick
    }
}
