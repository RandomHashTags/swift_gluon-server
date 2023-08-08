//
//  CPMPDisguisedChatMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Used to send system chat messages to the client.
    struct DisguisedChatMessage : ClientPacketMojangPlayProtocol {
        public let message:ChatPacketMojang
        /// The chat message type.
        public let chat_type:VariableInteger
        /// The name associated with the chat type. Usually the message sender's display name.
        public let chat_type_name:ChatPacketMojang
        /// True if target name is present.
        public let has_target_name:Bool
        /// The target name associated with the chat type. Usually the message target's display name. Only present if previous boolean is true.
        public let target_name:ChatPacketMojang
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [
                message,
                chat_type,
                chat_type_name,
                has_target_name,
                target_name
            ]
        }
    }
}
