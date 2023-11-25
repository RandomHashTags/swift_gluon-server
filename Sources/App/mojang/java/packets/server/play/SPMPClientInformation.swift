//
//  SPMPClientInformation.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Sent when the player connects, or when settings are changed.
    ///
    /// _Displayed Skin Parts_ flags:
    /// - Bit 0 (0x01): Cape enabled
    /// - Bit 1 (0x02): Jacket enabled
    /// - Bit 2 (0x04): Left Sleeve enabled
    /// - Bit 3 (0x08): Right Sleeve enabled
    /// - Bit 4 (0x10): Left Pants Leg enabled
    /// - Bit 5 (0x20): Right Pants Leg enabled
    /// - Bit 6 (0x40): Hat enabled
    ///
    /// The most significant bit (bit 7, 0x80) appears to be unused.
    struct ClientInformation : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.client_information
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let locale:String = try packet.read_string()
            let view_distance:Int8 = try packet.read_byte()
            let chat_mode:ClientInformation.ChatMode = try packet.read_enum()
            let chat_colors:Bool = try packet.read_bool()
            let displayed_skin_parts:UInt8 = try packet.read_unsigned_byte()
            let main_hand:ClientInformation.MainHand = try packet.read_enum()
            let enable_text_filtering:Bool = try packet.read_bool()
            let allow_server_listings:Bool = try packet.read_bool()
            return Self(locale: locale, view_distance: view_distance, chat_mode: chat_mode, chat_colors: chat_colors, displayed_skin_parts: displayed_skin_parts, main_hand: main_hand, enable_text_filtering: enable_text_filtering, allow_server_listings: allow_server_listings)
        }
        
        /// e.g. `en_GB`.
        public let locale:String
        /// Client-side render distance, in chunks.
        public let view_distance:Int8
        /// See [processing chat](https://wiki.vg/Chat#Processing_chat) for more information.
        public let chat_mode:ClientInformation.ChatMode
        /// “Colors” multiplayer setting. Can the chat be colored?
        public let chat_colors:Bool
        public let displayed_skin_parts:UInt8
        public let main_hand:ClientInformation.MainHand
        /// Enables filtering of text on signs and written book titles. Currently always false (i.e. the filtering is disabled)
        public let enable_text_filtering:Bool
        /// Servers usually list online players, this option should let you not show up in that list.
        public let allow_server_listings:Bool
        
        public enum ChatMode : Int, Hashable, Codable, PacketEncodableMojangJava {
            case enabled
            case commands_only
            case hidden
        }
        
        public enum MainHand : Int, Hashable, Codable, PacketEncodableMojangJava {
            case left
            case right
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                locale,
                view_distance,
                chat_mode,
                chat_colors,
                displayed_skin_parts,
                main_hand,
                enable_text_filtering,
                allow_server_listings
            ]
        }
    }
}
