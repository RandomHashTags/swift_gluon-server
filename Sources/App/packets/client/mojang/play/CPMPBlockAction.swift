//
//  CPMPBlockAction.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is used for a number of actions and animations performed by blocks, usually non-persistent. The client ignores the provided block type and instead uses the block state in their world.
    /// - Warning: This packet uses a block ID from the `minecraft:block` registry, not a block state.
    struct BlockAction : ClientPacketMojangProtocol {
        /// Block coordinates.
        let location:Int64
        let action_id:Int
        let action_parameter:Int
        /// The block type ID for the block. This value is unused by the Notchian client, as it will infer the type of block based on the given position.
        let block_type:Int
    }
}
