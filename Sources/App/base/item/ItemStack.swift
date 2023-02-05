//
//  ItemStack.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct ItemStack : Jsonable {
    public var material:Material
    public var meta:ItemMeta
    public var amount:UInt16
    public var durability:UInt16
    
    public func is_similar(_ item_stack: ItemStack) -> Bool {
        return material == item_stack.material && meta == item_stack.meta
    }
}
