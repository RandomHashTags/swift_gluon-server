//
//  CPMPTagQueryResponse.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent in response to Query Block Entity Tag or Query Entity Tag.
    struct TagQueryResponse : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.tag_query_response
        
        /// Can be compared to the one sent in the original query packet.
        public let transaction_id:VariableInteger
        /// The NBT of the block or entity. May be a TAG_END (0) in which case no NBT is present.
        public let nbt:Data // TODO: support NBT Tags
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [transaction_id, nbt]
        }
    }
}
