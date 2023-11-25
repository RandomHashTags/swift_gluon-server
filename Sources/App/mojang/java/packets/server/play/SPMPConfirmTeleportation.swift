//
//  SPMPConfirmTeleportation.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Sent by client as confirmation of [Synchronize Player Position](https://wiki.vg/Protocol#Synchronize_Player_Position ).
    struct ConfirmTeleportation : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.confirm_teleportation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let teleport_id:VariableIntegerJava = try packet.read_var_int()
            return Self(teleport_id: teleport_id)
        }
        
        /// The ID given by the [Synchronize Player Position](https://wiki.vg/Protocol#Synchronize_Player_Position) packet.
        public let teleport_id:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [teleport_id]
        }
    }
}
