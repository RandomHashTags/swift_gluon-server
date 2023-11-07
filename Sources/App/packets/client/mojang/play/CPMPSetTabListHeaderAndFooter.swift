//
//  CPMPSetTabListHeaderAndFooter.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet may be used by custom servers to display additional information above/below the player list. It is never sent by the Notchian server.
    struct SetTabListHeaderAndFooter : ClientPacketMojangPlayProtocol { // TODO: fix (parse)
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_tab_list_header_and_footer
        
        /// To remove the header, send a empty text component: `{"text":""}`.
        public let header:ChatPacketMojang
        /// To remove the header, send a empty text component: `{"text":""}`.
        public let footer:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [header, footer]
        }
    }
}
