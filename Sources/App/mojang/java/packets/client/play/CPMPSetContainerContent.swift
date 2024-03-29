//
//  CPMPSetContainerContent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetContainerContent : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_container_content
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:UInt8 = try packet.read_unsigned_byte()
            let state_id:VariableIntegerJava = try packet.read_var_int()
            let count:VariableIntegerJava = try packet.read_var_int()
            let slot_data:[SlotMojang] = try packet.read_packet_decodable_array(count: count)
            let carried_item:SlotMojang = try packet.read_packet_decodable()
            return Self(window_id: window_id, state_id: state_id, count: count, slot_data: slot_data, carried_item: carried_item)
        }
        
        /// The ID of window which items are being sent for. 0 for player inventory.
        public let window_id:UInt8
        /// The last received State ID from either a Set Container Slot or a Set Container Content packet.
        public let state_id:VariableIntegerJava
        /// Number of elements in `slot_data`.
        public let count:VariableIntegerJava
        public let slot_data:[SlotMojang]
        /// Item held by player.
        public let carried_item:SlotMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [window_id, state_id, count]
            array.append(contentsOf: slot_data)
            array.append(carried_item)
            return array
        }
    }
}
