//
//  CPMPPickupItem.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Sent by the server when someone picks up an item lying on the ground — its sole purpose appears to be the animation of the item flying towards you. It doesn't destroy the entity in the client memory, and it doesn't add it to your inventory. The server only checks for items to be picked up after each Set Player Position (and Set Player Position And Rotation) packet sent by the client. The collector entity can be any entity; it does not have to be a player. The collected entity also can be any entity, but the Notchian server only uses this for items, experience orbs, and the different varieties of arrows.
    struct PickupItem : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.pickup_item
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let collected_entity_id:VariableIntegerJava = try packet.readVarInt()
            let collector_entity_id:VariableIntegerJava = try packet.readVarInt()
            let pickup_item_count:VariableIntegerJava = try packet.readVarInt()
            return Self(collected_entity_id: collected_entity_id, collector_entity_id: collector_entity_id, pickup_item_count: pickup_item_count)
        }
        
        public let collected_entity_id:VariableIntegerJava
        public let collector_entity_id:VariableIntegerJava
        /// Seems to be 1 for XP orbs, otherwise the number of items in the stack.
        public let pickup_item_count:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [collected_entity_id, collector_entity_id, pickup_item_count]
        }
    }
}
