//
//  GluonItemStack.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItemStack : ItemStack {
    var materialID:String
    var material : (Material)? {
        return GluonServer.shared.get_material(identifier: materialID)
    }
    var meta:(ItemMeta)?
    var amount:UInt
    var durability:UInt
}
