//
//  ItemStack.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol ItemStack : Hashable {
    var material_id : String { get set }
    var material : (any Material)? { get }
    var meta : (any ItemMeta)? { get set }
    var amount : UInt { get set }
    var durability : UInt { get set }
    
    /// Whether or not two ``ItemStack`` are equal, regardless of amount.
    func is_similar(_ item_stack: (any ItemStack)?) -> Bool
}

public extension ItemStack {
    func is_similar(_ item_stack: (any ItemStack)?) -> Bool {
        return material_id == item_stack?.material_id && (meta != nil ? meta!.elementsEqual(item_stack?.meta) : item_stack?.meta != nil ? item_stack!.meta!.elementsEqual(meta) : true)
    }
}

public extension ItemStack {
    static func == (left: any ItemStack, right: any ItemStack) -> Bool {
        guard left.material_id.elementsEqual(right.material_id) && left.amount == right.amount && left.durability == right.durability else { return false }
        return true // TODO: fix
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    static func == (left: Self?, right: Self) -> Bool {
        return left != nil ? left! == right : false
    }
    static func == (left: Self, right: Self?) -> Bool {
        return right != nil ? left == right! : false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(material_id)
        if let meta:any ItemMeta = meta {
            hasher.combine(meta.display_name)
            hasher.combine(meta.lore)
            if let flags:[any ItemFlag] = meta.flags {
                for flag in flags {
                    hasher.combine(flag.id)
                }
            }
            hasher.combine(meta.enchants)
        }
        hasher.combine(amount)
        hasher.combine(durability)
    }
}
