//
//  CPMPCommandSuggestionsResponse.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// The server responds with a list of auto-completions of the last word sent to it. In the case of regular chat, this is a player username. Command names and parameters are also supported. The client sorts these alphabetically before listing them.
    struct CommandSuggestionsResponse : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let id:VariableInteger = try packet.read_var_int()
            let start:VariableInteger = try packet.read_var_int()
            let length:VariableInteger = try packet.read_var_int()
            let count:VariableInteger = try packet.read_var_int()
            let matches:[CommandSuggestionsResponse.Match] = try packet.read_map(count: count) {
                let match:String = try packet.read_string()
                let has_tooltip:Bool = try packet.read_bool()
                let tooltip:ChatPacketMojang? = nil // TODO: fix
                return CommandSuggestionsResponse.Match(match: match, has_tooltip: has_tooltip, tooltip: tooltip)
            }
            return Self(id: id, start: start, length: length, count: count, matches: matches)
        }
        
        /// Transaction ID.
        public let id:VariableInteger
        /// Start of the text to replace.
        public let start:VariableInteger
        /// Length of the text to replace.
        public let length:VariableInteger
        /// Number of elements in `matches`.
        public let count:VariableInteger
        public let matches:[CommandSuggestionsResponse.Match]
        
        public struct Match : Hashable, Codable, PacketEncodableMojang {
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
                    guard let tooltip:ChatPacketMojang = tooltip else {
                        throw GeneralPacketError.command_suggestions_response_match_missing_tooltip
                    }
                    array.append(contentsOf: try tooltip.packet_bytes())
                }
                return array
            }
        }
        
        public var encoded_values : [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [id, start, length, count]
            array.append(contentsOf: matches)
            return array
        }
    }
}
