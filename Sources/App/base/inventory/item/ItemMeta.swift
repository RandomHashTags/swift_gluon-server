//
//  ItemMeta.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol ItemMeta : Hashable {
    var display_name : String? { get set }
    var lore : [String]? { get set }
    var flags : [any ItemFlag]? { get set }
    /// ``EnchantmentType`` Identifier : Enchantment Level
    var enchants : [String : Int]? { get set }
}
public extension ItemMeta {
    private static func are_equal(left: any ItemMeta, right: any ItemMeta) -> Bool {
        guard left.display_name == right.display_name && left.lore == right.lore && left.flags?.count == right.flags?.count && left.enchants == right.enchants else { return false }
        return true // TODO: finish ItemFlag equivalence
    }
    static func == (lhs: any ItemMeta, rhs: any ItemMeta) -> Bool {
        return are_equal(left: lhs, right: rhs)
    }
    static func == (left: Self, right: Self) -> Bool {
        return are_equal(left: left, right: right)
    }
    
    func elementsEqual(_ meta: (any ItemMeta)?) -> Bool {
        guard let meta:any ItemMeta = meta else { return false }
        return Self.are_equal(left: self, right: meta)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(display_name)
        hasher.combine(lore)
        if let flags:[any ItemFlag] = flags {
            for flag in flags {
                hasher.combine(flag)
            }
        }
        hasher.combine(enchants)
    }
}
