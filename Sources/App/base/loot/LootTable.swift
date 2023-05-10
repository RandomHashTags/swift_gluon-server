//
//  LootTable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol LootTable : Jsonable {
    associatedtype TargetLootTableEntry : LootTableEntry
    associatedtype TargetItemStack : ItemStack
    
    var entries : [TargetLootTableEntry] { get }
    
    var loot_normal : [TargetItemStack]? { get }
}
public extension LootTable {
    var loot_normal : [TargetItemStack]? {
        let loot:[TargetItemStack] = entries.compactMap({ entry in
            let chance:UInt8 = UInt8.random(in: 0..<100)
            guard chance <= entry.chance else { return nil }
            var item:TargetItemStack = entry.item as! Self.TargetItemStack
            item.amount = UInt16.random(in: entry.amount_min...entry.amount_max)
            return item
        })
        return loot.isEmpty ? nil : loot
    }
}
