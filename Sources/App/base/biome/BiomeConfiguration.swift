//
//  BiomeConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct BiomeConfiguration : Jsonable {
    public let temperature:Float
    public let temperature_starting_y:Int64
    public let temperature_ending_y:Int64
    public let temperature_drop_rate:Float
    
    public let downfall:Float
}
