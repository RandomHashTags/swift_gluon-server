//
//  LootTable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct LootTable : Jsonable {
    public let item_chances:[ItemStack:Int8]
    
    public var loot_normal : [ItemStack] {
        return item_chances.compactMap({ (item, chance) in
            guard Int8.random(in: 0..<100) <= chance else { return nil }
            return item
        })
    }
}
