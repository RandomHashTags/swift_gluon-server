//
//  CPMPBlockUpdate.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Fired whenever a block is changed within the render distance.
    /// - Warning: Changing a block in a chunk that is not loaded is not a stable action. The Notchian client currently uses a _shared_ empty chunk which is modified for all block changes in unloaded chunks; while in 1.9 this chunk never renders in older versions the changed block will appear in all copies of the empty chunk. Servers should avoid sending block changes in unloaded chunks and clients should ignore such packets.
    struct BlockUpdate : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.block_update
        
        public let location:PositionPacketMojang
        /// Varies depending on block
        public let action_id:VariableInteger
        /*
        /// Varies depending on block
        public let action_parameter:Int
        /// The block type ID for the block. This value is unused by the Notchian client, as it will infer the type of block based on the given position.
        public let block_type:Int*/
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [location, action_id]
        }
    }
}
