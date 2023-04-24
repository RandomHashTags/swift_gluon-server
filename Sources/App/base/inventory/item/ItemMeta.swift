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
