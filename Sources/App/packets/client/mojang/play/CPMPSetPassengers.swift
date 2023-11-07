//
//  CPMPSetPassengers.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetPassengers : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_passengers
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let passenger_count:VariableInteger = try packet.read_var_int()
            let passengers:[VariableInteger] = try packet.read_packet_decodable_array(count: passenger_count)
            return Self(entity_id: entity_id, passenger_count: passenger_count, passengers: passengers)
        }
        
        public let entity_id:VariableInteger
        public let passenger_count:VariableInteger
        public let passengers:[VariableInteger]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[any PacketEncodableMojang] = [entity_id, passenger_count]
            array.append(contentsOf: passengers)
            return array
        }
    }
}
