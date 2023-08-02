//
//  CPMBlockUpdate.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang {
    /// Fired whenever a block is changed within the render distance.
    /// - Warning: Changing a block in a chunk that is not loaded is not a stable action. The Notchian client currently uses a _shared_ empty chunk which is modified for all block changes in unloaded chunks; while in 1.9 this chunk never renders in older versions the changed block will appear in all copies of the empty chunk. Servers should avoid sending block changes in unloaded chunks and clients should ignore such packets.
    struct BlockUpdate : ClientPacketMojangProtocol {
        let location:Int64
        /// Varies depending on block
        let action_id:Int
        /// Varies depending on block
        let action_parameter:Int
        /// The block type ID for the block. This value is unused by the Notchian client, as it will infer the type of block based on the given position.
        let block_type:Int
    }
}