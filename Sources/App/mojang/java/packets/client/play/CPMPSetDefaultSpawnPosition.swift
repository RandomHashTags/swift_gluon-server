//
//  CPMPSetDefaultSpawnPosition.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetDefaultSpawnPosition : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_default_spawn_position
        
        /// Sent by the server after login to specify the coordinates of the spawn point (the point at which players spawn at, and which the compass points to). It can be sent at any time to update the point compasses point at.
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let angle:Float = try packet.read_float()
            return Self(location: location, angle: angle)
        }
        
        /// Spawn location.
        public let location:PositionPacketMojang
        /// The angle at which to respawn at.
        public let angle:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [location, angle]
        }
    }
}
