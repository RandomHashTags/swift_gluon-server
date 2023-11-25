//
//  SPMPQueryBlockEntityTag.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Used when `F3+I` is pressed while looking at a block.
    struct QueryBlockEntityTag : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.query_block_entity_tag
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let transaction_id:VariableIntegerJava = try packet.read_var_int()
            let position:PositionPacketMojang = try packet.read_packet_decodable()
            return Self(transaction_id: transaction_id, position: position)
        }
        
        /// An incremental ID so that the client can verify that the response matches.
        public let transaction_id:VariableIntegerJava
        /// The location of the block to check.
        public let position:PositionPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [transaction_id, position]
        }
    }
}
