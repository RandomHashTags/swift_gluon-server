//
//  GluonItemStack.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItemStack : ItemStack {
    typealias TargetMaterial = GluonMaterial
    typealias TargetItemMeta = GluonItemMeta
    
    var material:TargetMaterial
    var meta:TargetItemMeta?
    var amount:UInt16
    var durability:UInt16
}
