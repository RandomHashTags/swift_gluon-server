//
//  GluonItemStack.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonItemStack : ItemStack {
    public typealias TargetMaterial = GluonMaterial
    public typealias TargetItemMeta = GluonItemMeta
    
    public var material:TargetMaterial
    public var meta:TargetItemMeta?
    public var amount:UInt16
    public var durability:UInt16
}
