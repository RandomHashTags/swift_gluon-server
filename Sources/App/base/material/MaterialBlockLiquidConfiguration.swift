//
//  MaterialBlockLiquidConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol MaterialBlockLiquidConfiguration : Hashable {
    func distance_per_tick(_ world: any World) -> Double
}
