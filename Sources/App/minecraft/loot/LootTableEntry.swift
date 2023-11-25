//
//  LootTable.swift
//
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol LootTableEntry {
    var item : any ItemStack { get }
    var amount_min : UInt { get }
    var amount_max : UInt { get }
    var chance : UInt8 { get }
}
