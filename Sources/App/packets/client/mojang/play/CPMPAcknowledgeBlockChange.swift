//
//  CPMPAcknowledgeBlockChange.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Acknowledges a user-initiated block change. After receiving this packet, the client will display the block state sent by the server instead of the one predicted by the client.
    struct AcknowledgeBlockChange : ClientPacketMojangProtocol {
        /// Represents the sequence to acknowledge, this is used for properly syncing block changes to the client after interactions.
        let sequence_id:Int
    }
}
