//
//  CPMPSetSimulationDistance.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetSimulationDistance : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_simulation_distance
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let distance:VariableIntegerJava = try packet.readVarInt()
            return Self(distance: distance)
        }
        
        /// The distance that the client will process specific things, such as entities.
        public let distance:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [distance]
        }
    }
}
