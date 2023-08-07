//
//  CPMPSystemChatMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Identifying the difference between Chat/System Message is important as it helps respect the user's chat visibility options. See processing chat for more info about these positions.
    struct SystemChatMessage : ClientPacketMojangPlayProtocol {
        /// Limited to 262144 bytes.
        public let content:ChatPacketMojang
        /// Whether the message is an actionbar or chat message.
        public let overlay:Bool
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [content, overlay]
        }
    }
}
