//
//  CPMPSetPassengers.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetPassengers : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_passengers
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let passengerCount:VariableIntegerJava = try packet.readVarInt()
            let passengers:[VariableIntegerJava] = try packet.read_packet_decodable_array(count: passengerCount)
            return Self(entityID: entityID, passengerCount: passengerCount, passengers: passengers)
        }
        
        public let entityID:VariableIntegerJava
        public let passengerCount:VariableIntegerJava
        public let passengers:[VariableIntegerJava]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [entityID, passengerCount]
            array.append(contentsOf: passengers)
            return array
        }
    }
}
