//
//  CPMPSetContainerContent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetContainerContent : ClientPacketMojangProtocol {
        /// The ID of window which items are being sent for. 0 for player inventory.
        let window_id:UInt8
        /// The last received State ID from either a Set Container Slot or a Set Container Content packet.
        let state_id:Int
        /// Number of elements in `slot_data`.
        let count:Int
        let slot_data:[SlotMojang]
        /// Item held by player.
        let carried_item:SlotMojang
    }
}
