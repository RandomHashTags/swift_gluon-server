//
//  ItemStack.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class ItemStack : Hashable {
    public static func == (lhs: ItemStack, rhs: ItemStack) -> Bool {
        return lhs.material == rhs.material && lhs.meta == rhs.meta && lhs.amount == rhs.amount && lhs.durability == rhs.durability
    }
    
    public var material:UnsafePointer<Material>
    public var meta:ItemMeta
    public var amount:UInt16
    public var durability:UInt16
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(material)
        hasher.combine(meta)
        hasher.combine(amount)
        hasher.combine(durability)
    }
    
    public init(material: UnsafePointer<Material>, meta: ItemMeta, amount: UInt16, durability: UInt16) {
        self.material = material
        self.meta = meta
        self.amount = amount
        self.durability = durability
    }
    
    public func is_similar(_ item_stack: ItemStack) -> Bool {
        return material == item_stack.material && meta == item_stack.meta
    }
}
