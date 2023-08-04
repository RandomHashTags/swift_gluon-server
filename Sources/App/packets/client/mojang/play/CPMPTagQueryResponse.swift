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
        /// Can be compared to the one sent in the original query packet.
        public let transaction_id:Int
        /// The NBT of the block or entity. May be a TAG_END (0) in which case no NBT is present.
        public let nbt:String // TODO: support NBT Tags
    }
}
