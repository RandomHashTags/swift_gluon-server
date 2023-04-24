//
//  ItemStack.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol ItemStack : Jsonable {
    associatedtype TargetMaterial : Material
    associatedtype TargetItemMeta : ItemMeta
    
    var material : TargetMaterial { get set }
    var meta : TargetItemMeta? { get set }
    var amount : UInt16 { get set }
    var durability : UInt16 { get set }
    
    func is_similar(_ item_stack: (any ItemStack)?) -> Bool
}

public extension ItemStack {
    func is_similar(_ item_stack: (any ItemStack)?) -> Bool {
        return material.identifier == item_stack?.material.identifier && meta == item_stack?.meta
    }
}
