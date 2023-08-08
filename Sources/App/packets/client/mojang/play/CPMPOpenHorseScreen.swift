//
//  CPMPOpenHorseScreen.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is used exclusively for opening the horse GUI. Open Screen is used for all other GUIs. The client will not open the inventory if the Entity ID does not point to an horse-like animal.
    struct OpenHorseScreen : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:UInt8 = try packet.read_unsigned_byte()
            let slot_count:VariableInteger = try packet.read_var_int()
            let entity_id:Int32 = try packet.read_int()
            return Self(window_id: window_id, slot_count: slot_count, entity_id: entity_id)
        }
        
        public let window_id:UInt8
        public let slot_count:VariableInteger
        public let entity_id:Int32
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [window_id, slot_count, entity_id]
        }
    }
}
