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
        let chance:Int8 = Int8.random(in: 0..<100)
        return item_chances.compactMap({ $1 <= chance ? $0 : nil })
    }
}
