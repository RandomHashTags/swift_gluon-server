//
//  LootTable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct LootTable {
    public let entries:[LootTableEntry]
}
public extension LootTable {
    var lootNormal : [ItemStack]? {
        let loot:[ItemStack] = entries.compactMap({ entry in
            let chance:UInt8 = UInt8.random(in: 0..<100)
            guard chance <= entry.chance else { return nil }
            var item:ItemStack = entry.item
            item.amount = UInt.random(in: entry.amountMin...entry.amountMax)
            return item
        })
        return loot.isEmpty ? nil : loot
    }
}
