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
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.unload_chunk
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let chunk_x:Int32 = try packet.read_int()
            let chunk_z:Int32 = try packet.read_int()
            return Self(chunk_x: chunk_x, chunk_z: chunk_z)
        }
        
        /// Block coordinate divided by 16, rounded down.
        public let chunk_x:Int32
        /// Block coordinate divided by 16, rounded down.
        public let chunk_z:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [chunk_x, chunk_z]
        }
    }
}
