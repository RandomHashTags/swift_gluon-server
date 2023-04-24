//
//  GluonItemMeta.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonItemMeta : ItemMeta {
    public typealias TargetItemFlag = GluonItemFlag
    
    public var display_name:String?
    public var lore:[String]?
    public var flags:Set<TargetItemFlag>?
    public var enchants:[EnchantmentType:Int]?
}
