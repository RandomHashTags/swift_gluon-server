//
//  GluonLootTableEntry.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonLootTableEntry : LootTableEntry {
    let item:any ItemStack
    let amount_min:UInt, amount_max:UInt
    let chance:UInt8
}
