//
//  LootTable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct LootTable : Jsonable {
    public let entries:[LootTableEntry]
    
    public var loot_normal : [ItemStack]? {
        let loot:[ItemStack] = entries.compactMap({ entry in
            let chance:UInt8 = UInt8.random(in: 0..<100)
            guard chance <= entry.chance else { return nil }
            var item:ItemStack = entry.item
            item.amount = UInt16.random(in: entry.amount_min...entry.amount_max)
            return item
        })
        return loot.isEmpty ? nil : loot
    }
}

public struct LootTableEntry : Jsonable {
    public let item:ItemStack
    public let amount_min:UInt16, amount_max:UInt16
    public let chance:UInt8
}
