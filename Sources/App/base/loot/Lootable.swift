//
//  Lootable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public class Lootable : Jsonable {
    public static func == (lhs: Lootable, rhs: Lootable) -> Bool {
        return lhs.loot_table == rhs.loot_table
    }
    
    public var loot_table:LootTable?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(loot_table)
    }
    
    public init(loot_table: LootTable?) {
        self.loot_table = loot_table
    }
}
