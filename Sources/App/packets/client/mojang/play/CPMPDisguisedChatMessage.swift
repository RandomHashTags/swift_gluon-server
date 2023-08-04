//
//  CPMPDisguisedChatMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Used to send system chat messages to the client.
    struct DisguisedChatMessage : ClientPacketMojangProtocol {
        let message:ChatPacketMojang
        /// The chat message type.
        let chat_type:Int
        /// The name associated with the chat type. Usually the message sender's display name.
        let chat_type_name:ChatPacketMojang
        /// True if target name is present.
        let has_target_name:Bool
        /// The target name associated with the chat type. Usually the message target's display name. Only present if previous boolean is true.
        let target_name:ChatPacketMojang
    }
}
