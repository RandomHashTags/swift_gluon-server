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
            let transactionID:VariableIntegerJava = try packet.readVarInt()
            let entityID:VariableIntegerJava = try packet.readVarInt()
            return Self(transactionID: transactionID, entityID: entityID)
        }
        
        /// An incremental ID so that the client can verify that the response matches.
        public let transactionID:VariableIntegerJava
        /// The ID of the entity to query.
        public let entityID:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [transactionID, entityID]
        }
    }
}
