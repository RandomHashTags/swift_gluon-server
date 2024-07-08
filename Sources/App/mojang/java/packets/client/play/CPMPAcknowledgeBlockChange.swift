//
//  CPMPAcknowledgeBlockChange.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Acknowledges a user-initiated block change. After receiving this packet, the client will display the block state sent by the server instead of the one predicted by the client.
    struct AcknowledgeBlockChange : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.acknowledge_block_change
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let sequence_id:VariableIntegerJava = try packet.readVarInt()
            return Self(sequence_id: sequence_id)
        }
        
        /// Represents the sequence to acknowledge, this is used for properly syncing block changes to the client after interactions.
        public let sequence_id:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [sequence_id]
        }
    }
}
