//
//  GluonLootTable.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonLootTable : LootTable {
    typealias TargetLootTableEntry = GluonLootTableEntry
    typealias TargetItemStack = GluonItemStack
    
    let entries:[TargetLootTableEntry]
}
