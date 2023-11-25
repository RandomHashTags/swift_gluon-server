//
//  CPMPSetPassengers.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetPassengers : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_passengers
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableIntegerJava = try packet.read_var_int()
            let passenger_count:VariableIntegerJava = try packet.read_var_int()
            let passengers:[VariableIntegerJava] = try packet.read_packet_decodable_array(count: passenger_count)
            return Self(entity_id: entity_id, passenger_count: passenger_count, passengers: passengers)
        }
        
        public let entity_id:VariableIntegerJava
        public let passenger_count:VariableIntegerJava
        public let passengers:[VariableIntegerJava]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [entity_id, passenger_count]
            array.append(contentsOf: passengers)
            return array
        }
    }
}
