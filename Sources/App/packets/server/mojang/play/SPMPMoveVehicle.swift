//
//  SPMPMoveVehicle.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when a player moves in a vehicle. Fields are the same as in [Set Player Position and Rotation](https://wiki.vg/Protocol#Set_Player_Position_and_Rotation ). Note that all fields use absolute positioning and do not allow for relative positioning.
    struct MoveVehicle : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let yaw:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            return Self(x: x, y: y, z: z, yaw: yaw, pitch: pitch)
        }
        
        /// Absolute position (X coordinate).
        public let x:Double
        /// Absolute position (Y coordinate).
        public let y:Double
        /// Absolute position (Z coordinate).
        public let z:Double
        /// Absolute rotation on the vertical axis, in degrees.
        public let yaw:Float
        /// Absolute rotation on the horizontal axis, in degrees.
        public let pitch:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [x, y, z, yaw, pitch]
        }
    }
}
