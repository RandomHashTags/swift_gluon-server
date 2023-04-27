//
//  GluonLootTableEntry.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonLootTableEntry : LootTableEntry {
    typealias TargetItemStack = GluonItemStack
    
    let item:TargetItemStack
    let amount_min:UInt16, amount_max:UInt16
    let chance:UInt8
}
