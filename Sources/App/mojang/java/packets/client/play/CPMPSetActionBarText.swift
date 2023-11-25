//
//  CPMPSetActionBarText.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetActionBarText : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_action_bar_text
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> ClientPacket.Mojang.Java.Play.SetActionBarText {
            let action_bar_text:ChatPacketMojang = try packet.read_packet_decodable()
            return Self(action_bar_text: action_bar_text)
        }
        
        /// Displays a message above the hotbar (the same as position 2 in [Player Chat Message](https://wiki.vg/Protocol#Player_Chat_Message )).
        public let action_bar_text:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [action_bar_text]
        }
    }
}
