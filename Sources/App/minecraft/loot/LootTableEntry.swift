//
//  LootTable.swift
//
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct LootTableEntry {
    public let item:ItemStack
    public let amountMin:UInt
    public let amountMax:UInt
    public let chance:UInt8
}
