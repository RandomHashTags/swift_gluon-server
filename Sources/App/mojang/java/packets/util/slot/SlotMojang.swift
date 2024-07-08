//
//  SlotMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

/// The **Slot** data structure is how Minecraft represents an item and its associated data in the Minecraft Protocol.
public struct SlotMojang : Codable, PacketEncodableMojangJava, PacketDecodableMojangJava {
    public static func decode(from packet: GeneralPacketMojang) throws -> SlotMojang {
        let present:Bool = try packet.readBool()
        let item_id:VariableIntegerJava?
        let item_count:Int8?
        let nbt:Data?
        if present {
            item_id = try packet.readVarInt()
            item_count = try packet.readByte()
            nbt = nil // TODO: fix
        } else {
            item_id = nil
            item_count = nil
            nbt = nil
        }
        return Self(present: present, item_id: item_id, item_count: item_count, nbt: nbt)
    }
    
    /// True if there is an item in this position; false if it is empty.
    public let present:Bool
    /// Omitted if present is false. The item ID. Item IDs are distinct from block IDs; see Data Generators for more information
    public let item_id:VariableIntegerJava?
    /// Omitted if present is false.
    public let item_count:Int8?
    /// Omitted if present is false.
    public let nbt:Data? // TODO: support NBT
    
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = try present.packet_bytes()
        if present {
            let precondition:String = "present == true"
            let item_id:VariableIntegerJava = try unwrap_optional(item_id, key_path: \Self.item_id, precondition: precondition)
            let item_count:Int8 = try unwrap_optional(item_count, key_path: \Self.item_count, precondition: precondition)
            let nbt:Data = try unwrap_optional(nbt, key_path: \Self.nbt, precondition: precondition)
            array.append(contentsOf: try item_id.packet_bytes())
            array.append(contentsOf: try item_count.packet_bytes())
            array.append(contentsOf: try nbt.packet_bytes())
        }
        return array
    }
}
