//
//  CPMPSetCenterChunk.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Updates the client's location. This is used to determine what chunks should remain loaded and if a chunk load should be ignored; chunks outside of the view distance may be unloaded.
    ///
    /// Sent whenever the player moves across a chunk border horizontally, and also (according to testing) for any integer change in the vertical axis, even if it doesn't go across a chunk section border.
    ///
    /// > Warning: \[from wiki.vg]: Why is this even needed? Is there a better name for it? My guess is that it's something to do with logical behavior with latency, but it still seems weird.
    struct SetCenterChunk : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_center_chunk
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let chunk_x:VariableIntegerJava = try packet.readVarInt()
            let chunk_z:VariableIntegerJava = try packet.readVarInt()
            return Self(chunk_x: chunk_x, chunk_z: chunk_z)
        }
        
        public let chunk_x:VariableIntegerJava
        public let chunk_z:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [chunk_x, chunk_z]
        }
    }
}
