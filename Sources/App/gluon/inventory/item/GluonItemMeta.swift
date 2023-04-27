//
//  GluonItemMeta.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItemMeta : ItemMeta {
    typealias TargetItemFlag = GluonItemFlag
    
    var display_name:String?
    var lore:[String]?
    var flags:Set<TargetItemFlag>?
    var enchants:[EnchantmentType:Int]?
}
