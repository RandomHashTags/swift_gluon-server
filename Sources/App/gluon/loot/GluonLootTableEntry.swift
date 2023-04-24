//
//  GluonLootTableEntry.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonLootTableEntry : Jsonable {
    public typealias TargetItemStack = GluonItemStack
    
    public let item:TargetItemStack
    public let amount_min:UInt16, amount_max:UInt16
    public let chance:UInt8
}
