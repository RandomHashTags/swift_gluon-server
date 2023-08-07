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
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let chunk_x:Int = try packet.read_int()
            let chunk_z:Int = try packet.read_int()
            return Self(chunk_x: chunk_x, chunk_z: chunk_z)
        }
        
        /// Block coordinate divided by 16, rounded down.
        public let chunk_x:Int
        /// Block coordinate divided by 16, rounded down.
        public let chunk_z:Int
        
        public var encoded_values: [PacketEncodableMojang?] {
            return [chunk_x, chunk_z]
        }
    }
}
