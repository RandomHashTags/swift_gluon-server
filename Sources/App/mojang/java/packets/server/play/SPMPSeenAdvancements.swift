//
//  SPMPSeenAdvancements.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    struct SeenAdvancements : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.seen_advancements
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let action:SeenAdvancements.Action = try packet.read_enum()
            let tab_id:Namespace? = action == .opened_tab ? try packet.read_identifier() : nil
            return Self(action: action, tab_id: tab_id)
        }
        
        public let action:SeenAdvancements.Action
        /// Only present if action is Opened tab.
        public let tab_id:Namespace?
        
        public enum Action : Int, Hashable, Codable, PacketEncodableMojangJava {
            case opened_tab
            case closed_screen
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [action]
            switch action {
            case .opened_tab:
                let tab_id:Namespace = try unwrap_optional(tab_id, key_path: \Self.tab_id, precondition: "action == .opened_tab")
                array.append(tab_id)
                break
            case .closed_screen:
                break
            }
            return array
        }
    }
}
