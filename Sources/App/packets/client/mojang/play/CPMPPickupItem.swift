//
//  CPMPPickupItem.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server when someone picks up an item lying on the ground — its sole purpose appears to be the animation of the item flying towards you. It doesn't destroy the entity in the client memory, and it doesn't add it to your inventory. The server only checks for items to be picked up after each Set Player Position (and Set Player Position And Rotation) packet sent by the client. The collector entity can be any entity; it does not have to be a player. The collected entity also can be any entity, but the Notchian server only uses this for items, experience orbs, and the different varieties of arrows.
    struct PickupItem : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let collected_entity_id:VariableInteger = try packet.read_var_int()
            let collector_entity_id:VariableInteger = try packet.read_var_int()
            let pickup_item_count:VariableInteger = try packet.read_var_int()
            return Self(collected_entity_id: collected_entity_id, collector_entity_id: collector_entity_id, pickup_item_count: pickup_item_count)
        }
        
        public let collected_entity_id:VariableInteger
        public let collector_entity_id:VariableInteger
        /// Seems to be 1 for XP orbs, otherwise the number of items in the stack.
        public let pickup_item_count:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [collected_entity_id, collector_entity_id, pickup_item_count]
        }
    }
}
