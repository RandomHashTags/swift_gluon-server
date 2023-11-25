//
//  SPMPSetPlayerRotation.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Updates the direction the player is looking in.
    ///
    /// Yaw is measured in degrees, and does not follow classical trigonometry rules. The unit circle of yaw on the XZ-plane starts at (0, 1) and turns counterclockwise, with 90 at (-1, 0), 180 at (0,-1) and 270 at (1, 0). Additionally, yaw is not clamped to between 0 and 360 degrees; any number is valid, including negative numbers and numbers greater than 360.
    ///
    /// Pitch is measured in degrees, where 0 is looking straight ahead, -90 is looking straight up, and 90 is looking straight down.
    ///
    /// The yaw and pitch of player (in degrees), standing at point (x0, y0, z0) and looking towards point (x, y, z) can be calculated with:
    /// ```swift
    /// dx = x-x0
    /// dy = y-y0
    /// dz = z-z0
    /// r = sqrt( dx*dx + dy*dy + dz*dz )
    /// yaw = -atan2(dx,dz)/PI*180
    /// if yaw < 0 {
    ///    yaw = 360 + yaw
    /// }
    /// pitch = -arcsin(dy/r)/PI*180
    /// ```
    ///
    /// You can get a unit vector from a given yaw/pitch via:
    /// ```swift
    /// x = -cos(pitch) * sin(yaw)
    /// y = -sin(pitch)
    /// z =  cos(pitch) * cos(yaw)
    /// ```
    struct SetPlayerRotation : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.set_player_rotation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let yaw:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            let on_ground:Bool = try packet.read_bool()
            return Self(yaw: yaw, pitch: pitch, on_ground: on_ground)
        }
        
        /// Absolute rotation on the X Axis, in degrees.
        public let yaw:Float
        /// Absolute rotation on the Y Axis, in degrees.
        public let pitch:Float
        /// True if the client is on the ground, false otherwise.
        public let on_ground:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [yaw, pitch, on_ground]
        }
    }
}
