//
//  MaterialBlockGrowableConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/16/23.
//

import Foundation

public struct MaterialBlockGrowableConfiguration : Jsonable {
    public let maximum_age:UInt8
    public let minimum_light_level_to_grow:UInt8
}
