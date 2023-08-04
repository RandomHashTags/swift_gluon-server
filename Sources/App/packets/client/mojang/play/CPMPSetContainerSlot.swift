//
//  CPMPSetContainerSlot.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server when an item in a slot (in a window) is added/removed.
    ///
    /// To set the cursor (the item currently dragged with the mouse), use -1 as Window ID and as Slot.
    ///
    /// This packet can only be used to edit the hotbar and offhand of the player's inventory if window ID is set to 0 (slots 36 through 45) if the player is in creative, with their inventory open, and not in their survival inventory tab. Otherwise, when window ID is 0, it can edit any slot in the player's inventory. If the window ID is set to -2, then any slot in the inventory can be used but no add item animation will be played.
    struct SetContainerSlot : ClientPacketMojangPlayProtocol {
        /// The window which is being updated. 0 for player inventory.
        /// > Note: All known window types include the player inventory. This packet will only be sent for the currently opened window while the player is performing actions, even if it affects the player inventory. After the window is closed, a number of these packets are sent to update the player's inventory window (0).
        public let window_id:UInt8
        /// The last received State ID from either a Set Container Slot or a Set Container Content packet.
        public let state_id:Int
        /// The slot that should be updated.
        public let slot:Int
        public let slot_data:SlotMojang
    }
}
