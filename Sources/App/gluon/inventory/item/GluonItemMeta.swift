//
//  GluonItemMeta.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItemMeta : ItemMeta {
    var display_name:String?
    var lore:[String]?
    var flags:[any ItemFlag]?
    var enchants:[String:Int]?
}
