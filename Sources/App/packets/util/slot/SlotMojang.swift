//
//  SlotMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

/// The **Slot** data structure is how Minecraft represents an item and its associated data in the Minecraft Protocol.
public struct SlotMojang : Hashable, Codable {
    /// True if there is an item in this position; false if it is empty.
    let present:Bool
    /// Omitted if present is false. The item ID. Item IDs are distinct from block IDs; see Data Generators for more information
    let item_id:Int?
    /// Omitted if present is false.
    let item_count:UInt8
    /// Omitted if present is false.
    let nbt:Data? // TODO: support NBT
}
