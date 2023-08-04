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
        /// Transaction ID.
        public let id:Int
        /// Start of the text to replace.
        public let start:Int
        /// Length of the text to replace.
        public let length:Int
        /// Number of elements in `matches`.
        public let count:Int
        public let matches:[CommandSuggestionsResponse.Match]
        
        public struct Match : Hashable, Codable {
            /// One eligible value to insert, note that each command is sent separately instead of in a single string, hence the need for `count`.
            /// > Note: Doesn't include a leading `/` on commands.
            public let match:String
            public let has_tooltip:Bool
            /// Tooltip to display; only present if `has_tooltip` is true.
            public let tooltip:ChatPacketMojang?
        }
    }
}
