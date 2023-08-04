//
//  CPMPSetCooldown.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Applies a cooldown period to all items with the given type. Used by the Notchian server with enderpearls. This packet should be sent when the cooldown starts and also when the cooldown ends (to compensate for lag), although the client will end the cooldown automatically. Can be applied to any item.
    /// > Note: Interactions still get sent to the server with the item but the client does not play the animation nor attempt to predict results (i.e block placing).
    struct SetCooldown : ClientPacketMojangPlayProtocol {
        /// Numeric ID of the item to apply a cooldown to.
        public let item_id:Int
        /// Number of ticks to apply a cooldown for, or 0 to clear the cooldown.
        public let cooldown_ticks:Int
    }
}
