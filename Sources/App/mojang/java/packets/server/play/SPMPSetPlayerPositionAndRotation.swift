//
//  SPMPSetPlayerPositionAndRotation.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// A combination of [Move Player Rotation](https://wiki.vg/Protocol#Set_Player_Rotation) and [Move Player Position](https://wiki.vg/Protocol#Set_Player_Position ).
    struct SetPlayerPositionAndRotation : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.set_player_position_and_rotation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let x:Double = try packet.read_double()
            let feet_y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let yaw:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            let on_ground:Bool = try packet.read_bool()
            return Self(x: x, feet_y: feet_y, z: z, yaw: yaw, pitch: pitch, on_ground: on_ground)
        }
        
        /// Absolute position.
        public let x:Double
        /// Absolute feet position, normally Head Y - 1.62.
        public let feet_y:Double
        /// Absolute position.
        public let z:Double
        /// Absolute rotation on the X Axis, in degrees.
        public let yaw:Float
        /// Absolute rotation on the Y Axis, in degrees.
        public let pitch:Float
        /// True if the client is on the ground, false otherwise.
        public let on_ground:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [x, feet_y, z, yaw, pitch, on_ground]
        }
    }
}
