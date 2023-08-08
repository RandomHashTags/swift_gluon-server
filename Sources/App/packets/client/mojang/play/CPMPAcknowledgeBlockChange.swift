//
//  CPMPAcknowledgeBlockChange.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Acknowledges a user-initiated block change. After receiving this packet, the client will display the block state sent by the server instead of the one predicted by the client.
    struct AcknowledgeBlockChange : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let sequence_id:VariableInteger = try packet.read_var_int()
            return Self(sequence_id: sequence_id)
        }
        
        /// Represents the sequence to acknowledge, this is used for properly syncing block changes to the client after interactions.
        public let sequence_id:VariableInteger
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [sequence_id]
        }
    }
}
