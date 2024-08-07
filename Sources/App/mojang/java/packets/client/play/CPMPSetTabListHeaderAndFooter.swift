//
//  CPMPSetTabListHeaderAndFooter.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This packet may be used by custom servers to display additional information above/below the player list. It is never sent by the Notchian server.
    struct SetTabListHeaderAndFooter : ClientPacket.Mojang.Java.PlayProtocol { // TODO: fix (parse)
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_tab_list_header_and_footer
        
        /// To remove the header, send a empty text component: `{"text":""}`.
        public let header:ChatPacketMojang
        /// To remove the header, send a empty text component: `{"text":""}`.
        public let footer:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [header, footer]
        }
    }
}
