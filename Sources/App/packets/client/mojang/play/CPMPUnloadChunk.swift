//
//  CPMPUnloadChunk.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Tells the client to unload a chunk column.
    ///
    /// It is legal to send this packet even if the given chunk is not currently loaded.
    struct UnloadChunk : ClientPacketMojangPlayProtocol {
        /// Block coordinate divided by 16, rounded down.
        public let chunk_x:Int
        /// Block coordinate divided by 16, rounded down.
        public let chunk_z:Int
    }
}
