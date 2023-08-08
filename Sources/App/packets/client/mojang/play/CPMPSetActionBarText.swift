//
//  CPMPSetActionBarText.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetActionBarText : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> ClientPacketMojang.Play.SetActionBarText {
            let action_bar_text:ChatPacketMojang = try packet.read_packet_decodable()
            return Self(action_bar_text: action_bar_text)
        }
        
        /// Displays a message above the hotbar (the same as position 2 in [Player Chat Message](https://wiki.vg/Protocol#Player_Chat_Message )).
        public let action_bar_text:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [action_bar_text]
        }
    }
}
