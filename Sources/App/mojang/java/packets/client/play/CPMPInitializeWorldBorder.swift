//
//  CPMPInitializeWorldBorder.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// !
    ///
    /// The Notchian client determines how solid to display the warning by comparing to whichever is higher, the warning distance or whichever is lower, the distance from the current diameter to the target diameter or the place the border will be after warningTime seconds.
    struct InitializeWorldBorder : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.initialize_world_border
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let x:Double = try packet.readDouble()
            let z:Double = try packet.readDouble()
            let old_diameter:Double = try packet.readDouble()
            let new_diameter:Double = try packet.readDouble()
            let speed:VariableLongJava = try packet.readVarLong()
            let portal_teleport_boundary:VariableIntegerJava = try packet.readVarInt()
            let warning_blocks:VariableIntegerJava = try packet.readVarInt()
            let warningTime:VariableIntegerJava = try packet.readVarInt()
            return Self(x: x, z: z, old_diameter: old_diameter, new_diameter: new_diameter, speed: speed, portal_teleport_boundary: portal_teleport_boundary, warning_blocks: warning_blocks, warningTime: warningTime)
        }
        
        public let x:Double
        public let z:Double
        /// Current length of a single side of the world border, in meters.
        public let old_diameter:Double
        /// Target length of a single side of the world border, in meters.
        public let new_diameter:Double
        /// Number of real-time _milliseconds_ until New Diameter is reached. It appears that Notchian server does not sync world border speed to game ticks, so it gets out of sync with server lag. If the world border is not moving, this is set to 0.
        public let speed:VariableLongJava
        /// Resulting coordinates from a portal teleport are limited to ±value. Usually 29999984.
        public let portal_teleport_boundary:VariableIntegerJava
        /// In meters.
        public let warning_blocks:VariableIntegerJava
        /// In seconds as set by `/worldborder warning time`.
        public let warningTime:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                x,
                z,
                old_diameter,
                new_diameter,
                speed,
                portal_teleport_boundary,
                warning_blocks,
                warningTime
            ]
        }
    }
}
