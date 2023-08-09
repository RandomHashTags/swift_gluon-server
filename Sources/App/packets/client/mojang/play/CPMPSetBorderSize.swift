//
//  CPMPSetBorderSize.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetBorderSize : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let diameter:Double = try packet.read_double()
            return Self(diameter: diameter)
        }
        
        /// Length of a single side of the world border, in meters.
        public let diameter:Double
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [diameter]
        }
    }
}