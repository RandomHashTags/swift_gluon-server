//
//  GluonMaterialBlockLiquidConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialBlockLiquidConfiguration : MaterialBlockLiquidConfiguration {
    let distances_per_tick:[String:Double]
    
    func distance_per_tick(_ world: any World) -> Double {
        return distances_per_tick[world.name] ?? 0
    }
}
