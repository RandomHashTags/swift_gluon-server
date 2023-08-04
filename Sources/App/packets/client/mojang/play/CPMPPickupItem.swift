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
        public let collected_entity_id:Int
        public let collector_entity_id:Int
        /// Seems to be 1 for XP orbs, otherwise the number of items in the stack.
        public let pickup_item_count:Int
    }
}
