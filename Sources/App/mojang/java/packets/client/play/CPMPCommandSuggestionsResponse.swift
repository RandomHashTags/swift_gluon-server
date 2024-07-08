//
//  CPMPCommandSuggestionsResponse.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// The server responds with a list of auto-completions of the last word sent to it. In the case of regular chat, this is a player username. Command names and parameters are also supported. The client sorts these alphabetically before listing them.
    struct CommandSuggestionsResponse : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.command_suggestions_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:VariableIntegerJava = try packet.readVarInt()
            let start:VariableIntegerJava = try packet.readVarInt()
            let length:VariableIntegerJava = try packet.readVarInt()
            let count:VariableIntegerJava = try packet.readVarInt()
            let matches:[CommandSuggestionsResponse.Match] = try packet.read_map(count: count) {
                let match:String = try packet.readString()
                let has_tooltip:Bool = try packet.readBool()
                let tooltip:ChatPacketMojang? = nil // TODO: fix
                return CommandSuggestionsResponse.Match(match: match, has_tooltip: has_tooltip, tooltip: tooltip)
            }
            return Self(id: id, start: start, length: length, count: count, matches: matches)
        }
        
        /// Transaction ID.
        public let id:VariableIntegerJava
        /// Start of the text to replace.
        public let start:VariableIntegerJava
        /// Length of the text to replace.
        public let length:VariableIntegerJava
        /// Number of elements in `matches`.
        public let count:VariableIntegerJava
        public let matches:[CommandSuggestionsResponse.Match]
        
        public struct Match : Codable, PacketEncodableMojangJava {
            /// One eligible value to insert, note that each command is sent separately instead of in a single string, hence the need for `count`.
            /// > Note: Doesn't include a leading `/` on commands.
            public let match:String
            public let has_tooltip:Bool
            /// Tooltip to display; only present if `has_tooltip` is true.
            public let tooltip:ChatPacketMojang?
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = try match.packet_bytes()
                array.append(contentsOf: try has_tooltip.packet_bytes())
                if has_tooltip {
                    let tooltip:ChatPacketMojang = try unwrap_optional(tooltip, key_path: \Self.tooltip, precondition: "has_tooltip == true")
                    array.append(contentsOf: try tooltip.packet_bytes())
                }
                return array
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [id, start, length, count]
            array.append(contentsOf: matches)
            return array
        }
    }
}
