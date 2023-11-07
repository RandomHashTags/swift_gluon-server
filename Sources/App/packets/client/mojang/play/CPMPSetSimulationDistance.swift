//
//  CPMPSetSimulationDistance.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetSimulationDistance : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_simulation_distance
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let distance:VariableInteger = try packet.read_var_int()
            return Self(distance: distance)
        }
        
        /// The distance that the client will process specific things, such as entities.
        public let distance:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [distance]
        }
    }
}
