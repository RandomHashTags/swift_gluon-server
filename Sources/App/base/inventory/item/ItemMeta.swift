//
//  ItemMeta.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct ItemMeta : Jsonable {
    public var display_name:String?
    public var lore:[String]?
    public var flags:Set<ItemFlag>?
    public var enchants:[EnchantmentType:Int]?
}
