//
//  CPMPSetBorderLerpSize.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetBorderLerpSize : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let old_diameter:Double = try packet.read_double()
            let new_diameter:Double = try packet.read_double()
            let speed:VariableLong = try packet.read_var_long()
            return Self(old_diameter: old_diameter, new_diameter: new_diameter, speed: speed)
        }
        
        /// Current length of a single side of the world border, in meters.
        public let old_diameter:Double
        /// Target length of a single side of the world border, in meters.
        public let new_diameter:Double
        /// Number of real-time _milliseconds_ until New Diameter is reached. It appears that Notchian server does not sync world border speed to game ticks, so it gets out of sync with server lag. If the world border is not moving, this is set to 0.
        public let speed:VariableLong
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [old_diameter, new_diameter, speed]
        }
    }
}
