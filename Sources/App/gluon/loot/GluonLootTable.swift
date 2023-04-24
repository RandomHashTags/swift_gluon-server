//
//  GluonLootTable.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonLootTable : Jsonable {
    public typealias TargetLootTableEntry = GluonLootTableEntry
    public typealias TargetItemStack = GluonItemStack
    
    public let entries:[TargetLootTableEntry]
    
    public var loot_normal : [TargetItemStack]? {
        let loot:[TargetItemStack] = entries.compactMap({ entry in
            let chance:UInt8 = UInt8.random(in: 0..<100)
            guard chance <= entry.chance else { return nil }
            var item:TargetItemStack = entry.item
            item.amount = UInt16.random(in: entry.amount_min...entry.amount_max)
            return item
        })
        return loot.isEmpty ? nil : loot
    }
}
