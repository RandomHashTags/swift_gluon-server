//
//  MaterialItemConsumableConfiguration.swift
//  
//
//  Created by Evan Anderson on 3/5/23.
//

import Foundation

public struct MaterialItemConsumableConfiguration : Jsonable {
    public let identifier:String
    /// Amount of ticks required of consuming to consider this item to be consumed.
    public internal(set) var duration:UInt64
    /// The logic executed when this item is considered consumed.
    public let code:[String]
}
