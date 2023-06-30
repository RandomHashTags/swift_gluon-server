//
//  LootTable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol LootTable {
    var entries : [any LootTableEntry] { get }
    
    var loot_normal : [any ItemStack]? { get }
}
public extension LootTable {
    var loot_normal : [any ItemStack]? {
        let loot:[any ItemStack] = entries.compactMap({ entry in
            let chance:UInt8 = UInt8.random(in: 0..<100)
            guard chance <= entry.chance else { return nil }
            var item:any ItemStack = entry.item
            item.amount = UInt16.random(in: entry.amount_min...entry.amount_max)
            return item
        })
        return loot.isEmpty ? nil : loot
    }
}
