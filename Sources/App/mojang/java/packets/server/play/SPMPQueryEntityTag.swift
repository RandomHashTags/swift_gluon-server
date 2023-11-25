//
//  SPMPQueryEntityTag.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Used when F3+I is pressed while looking at an entity.
    struct QueryEntityTag : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.query_entity_tag
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let transaction_id:VariableIntegerJava = try packet.read_var_int()
            let entity_id:VariableIntegerJava = try packet.read_var_int()
            return Self(transaction_id: transaction_id, entity_id: entity_id)
        }
        
        /// An incremental ID so that the client can verify that the response matches.
        public let transaction_id:VariableIntegerJava
        /// The ID of the entity to query.
        public let entity_id:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [transaction_id, entity_id]
        }
    }
}
