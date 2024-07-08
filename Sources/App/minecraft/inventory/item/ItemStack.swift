//
//  ItemStack.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct ItemStack : Hashable {
    public var materialID:String
    public var meta:ItemMeta?
    public var amount:UInt
    public var durability:UInt
    
    /// Whether or not two ``ItemStack`` are equal, regardless of amount.
    func isSimilar(_ item_stack: ItemStack?) -> Bool {
        return materialID == item_stack?.materialID && (meta == item_stack?.meta)
    }
}