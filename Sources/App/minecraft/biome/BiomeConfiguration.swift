//
//  BiomeConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct BiomeConfiguration : Identifiable, Hashable {
    public let id:String
    public let temperature:Float
    public let temperatureStartingY:Int
    public let temperatureEndingY:Int
    public let temperatureDropRate:Float
    
    public let downfall:Float
}
