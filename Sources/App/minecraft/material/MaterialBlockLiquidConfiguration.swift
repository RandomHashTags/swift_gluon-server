//
//  MaterialBlockLiquidConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol MaterialBlockLiquidConfiguration : AnyObject, Hashable, ServerTickChangeListener {
    /// ``World`` name : distance per tick
    var distances_per_tick : [String:Double] { get set }
}

public extension MaterialBlockLiquidConfiguration {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        let divisor:Double = Double(divisor)
        for (world_name, _) in distances_per_tick {
            distances_per_tick[world_name]! /= divisor
        }
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        let multiplier:Double = Double(multiplier)
        for (world_name, _) in distances_per_tick {
            distances_per_tick[world_name]! *= multiplier
        }
    }
}

public extension MaterialBlockLiquidConfiguration {
    static func == (left: any MaterialBlockLiquidConfiguration, right: any MaterialBlockLiquidConfiguration) -> Bool {
        return left.distances_per_tick == right.distances_per_tick
    }
    static func == (left: Self, right: Self) -> Bool {
        return left.distances_per_tick == right.distances_per_tick
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(distances_per_tick)
    }
}
