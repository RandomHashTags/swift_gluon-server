//
//  CPMPSetSimulationDistance.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetSimulationDistance : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let distance:VariableInteger = try packet.read_var_int()
            return Self(distance: distance)
        }
        
        /// The distance that the client will process specific things, such as entities.
        public let distance:VariableInteger
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [distance]
        }
    }
}
