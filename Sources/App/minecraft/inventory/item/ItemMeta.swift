//
//  ItemMeta.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct ItemMeta : Hashable {
    public var displayName:String?
    public var lore:[String]?
    public var flags:[ItemFlag]?
    /// ``EnchantmentType`` Identifier : Enchantment Level
    public var enchants:[EnchantmentType.ID:Int]?
}
public extension ItemMeta {
    static func == (left: ItemMeta, right: ItemMeta) -> Bool {
        guard left.displayName == right.displayName && left.lore == right.lore && left.flags?.count == right.flags?.count && left.enchants == right.enchants else { return false }
        return true // TODO: finish ItemFlag equivalence
    }
}
