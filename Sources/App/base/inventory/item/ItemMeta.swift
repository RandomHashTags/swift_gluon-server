//
//  ItemMeta.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol ItemMeta : Jsonable {
    associatedtype TargetItemFlag : ItemFlag
    
    var display_name : String? { get set }
    var lore : [String]? { get set }
    var flags : Set<TargetItemFlag>? { get set }
    var enchants : [EnchantmentType:Int]? { get set }
}
public extension ItemMeta {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.display_name == rhs.display_name && lhs.lore == rhs.lore && lhs.flags == rhs.flags && lhs.enchants == rhs.enchants
    }
}
