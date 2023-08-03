//
//  CPMPCommandSuggestionsResponse.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// The server responds with a list of auto-completions of the last word sent to it. In the case of regular chat, this is a player username. Command names and parameters are also supported. The client sorts these alphabetically before listing them.
    struct CommandSuggestionsResponse : ClientPacketMojangProtocol {
        /// Transaction ID.
        let id:Int
        /// Start of the text to replace.
        let start:Int
        /// Length of the text to replace.
        let length:Int
        /// Number of elements in `matches`.
        let count:Int
        let matches:[CommandSuggestionsResponse.Match]
        
        struct Match : Hashable, Codable {
            /// One eligible value to insert, note that each command is sent separately instead of in a single string, hence the need for `count`. Note that for instance this doesn't include a leading `/` on commands.
            let match:String
            let has_tooltip:Bool
            /// Tooltip to display; only present if `has_tooltip` is true.
            let tooltip:ChatPacketMojang?
        }
    }
}
