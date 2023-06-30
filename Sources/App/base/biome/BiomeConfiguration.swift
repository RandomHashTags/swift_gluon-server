//
//  BiomeConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol BiomeConfiguration : Hashable {
    var temperature : Float { get }
    var temperature_starting_y : Int64 { get }
    var temperature_ending_y : Int64 { get }
    var temperature_drop_rate : Float { get }
    
    var downfall : Float { get }
}
