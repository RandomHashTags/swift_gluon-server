//
//  SlotMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

/// The **Slot** data structure is how Minecraft represents an item and its associated data in the Minecraft Protocol.
public struct SlotMojang : Hashable, Codable, PacketEncodableMojang, PacketDecodableMojang {
    public static func decode(from packet: GeneralPacketMojang) throws -> SlotMojang {
        let present:Bool = try packet.read_bool()
        let item_id:VariableInteger?
        let item_count:Int8?
        let nbt:Data?
        if present {
            item_id = try packet.read_var_int()
            item_count = try packet.read_byte()
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
    public let item_id:VariableInteger?
    /// Omitted if present is false.
    public let item_count:Int8?
    /// Omitted if present is false.
    public let nbt:Data? // TODO: support NBT
    
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = try present.packet_bytes()
        if present {
            guard let item_id:VariableInteger = item_id else {
                throw GeneralPacketError.optional_value_cannot_be_optional(type: Self.self, value: "item_id", precondition: "present == true")
            }
            guard let item_count:Int8 = item_count else {
                throw GeneralPacketError.optional_value_cannot_be_optional(type: Self.self, value: "item_count", precondition: "present == true")
            }
            guard let nbt:Data = nbt else {
                throw GeneralPacketError.optional_value_cannot_be_optional(type: Self.self, value: "nbt", precondition: "present == true")
            }
            array.append(contentsOf: try item_id.packet_bytes())
            array.append(contentsOf: try item_count.packet_bytes())
            array.append(contentsOf: try nbt.packet_bytes())
        }
        return array
    }
}
