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
