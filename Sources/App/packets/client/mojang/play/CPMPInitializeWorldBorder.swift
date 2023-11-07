//
//  CPMPInitializeWorldBorder.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// !
    ///
    /// The Notchian client determines how solid to display the warning by comparing to whichever is higher, the warning distance or whichever is lower, the distance from the current diameter to the target diameter or the place the border will be after warningTime seconds.
    struct InitializeWorldBorder : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.initialize_world_border
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let x:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let old_diameter:Double = try packet.read_double()
            let new_diameter:Double = try packet.read_double()
            let speed:VariableLong = try packet.read_var_long()
            let portal_teleport_boundary:VariableInteger = try packet.read_var_int()
            let warning_blocks:VariableInteger = try packet.read_var_int()
            let warning_time:VariableInteger = try packet.read_var_int()
            return Self(x: x, z: z, old_diameter: old_diameter, new_diameter: new_diameter, speed: speed, portal_teleport_boundary: portal_teleport_boundary, warning_blocks: warning_blocks, warning_time: warning_time)
        }
        
        public let x:Double
        public let z:Double
        /// Current length of a single side of the world border, in meters.
        public let old_diameter:Double
        /// Target length of a single side of the world border, in meters.
        public let new_diameter:Double
        /// Number of real-time _milliseconds_ until New Diameter is reached. It appears that Notchian server does not sync world border speed to game ticks, so it gets out of sync with server lag. If the world border is not moving, this is set to 0.
        public let speed:VariableLong
        /// Resulting coordinates from a portal teleport are limited to ±value. Usually 29999984.
        public let portal_teleport_boundary:VariableInteger
        /// In meters.
        public let warning_blocks:VariableInteger
        /// In seconds as set by `/worldborder warning time`.
        public let warning_time:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [
                x,
                z,
                old_diameter,
                new_diameter,
                speed,
                portal_teleport_boundary,
                warning_blocks,
                warning_time
            ]
        }
    }
}
