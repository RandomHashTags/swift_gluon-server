//
//  SPMPConfirmTeleportation.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent by client as confirmation of [Synchronize Player Position](https://wiki.vg/Protocol#Synchronize_Player_Position ).
    struct ConfirmTeleportation : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.confirm_teleportation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let teleport_id:VariableInteger = try packet.read_var_int()
            return Self(teleport_id: teleport_id)
        }
        
        public static func process(_ client: ServerMojangClient) {
            
        }
        
        /// The ID given by the [Synchronize Player Position](https://wiki.vg/Protocol#Synchronize_Player_Position) packet.
        public let teleport_id:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [teleport_id]
        }
    }
}
