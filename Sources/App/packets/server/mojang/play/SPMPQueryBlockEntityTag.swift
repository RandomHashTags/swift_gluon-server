//
//  SPMPQueryBlockEntityTag.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Used when `F3+I` is pressed while looking at a block.
    struct QueryBlockEntityTag : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.query_block_entity_tag
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let transaction_id:VariableInteger = try packet.read_var_int()
            let position:PositionPacketMojang = try packet.read_packet_decodable()
            return Self(transaction_id: transaction_id, position: position)
        }
        
        /// An incremental ID so that the client can verify that the response matches.
        public let transaction_id:VariableInteger
        /// The location of the block to check.
        public let position:PositionPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [transaction_id, position]
        }
    }
}
