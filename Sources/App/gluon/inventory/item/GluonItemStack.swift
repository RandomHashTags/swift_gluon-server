//
//  GluonItemStack.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItemStack : ItemStack {
    var material_id:String
    var material : (any Material)? {
        return GluonServer.shared_instance.get_material(identifier: material_id)
    }
    var meta:(any ItemMeta)?
    var amount:UInt16
    var durability:UInt16
}
