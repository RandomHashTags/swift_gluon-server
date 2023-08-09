//
//  CPMPSetRenderDistance.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the integrated singleplayer server when changing render distance. This packet is sent by the server when the client reappears in the overworld after leaving the end.
    struct SetRenderDistance : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let view_distance:VariableInteger = try packet.read_var_int()
            return Self(view_distance: view_distance)
        }
        
        /// Render distance (2-32).
        public let view_distance:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [view_distance]
        }
    }
}
