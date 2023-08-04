//
//  CPMPChatSuggestions.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Unused by the Notchian server. Likely provided for custom servers to send chat message completions to clients.
    struct ChatSuggestions : ClientPacketMojangProtocol {
        let action:ChatSuggestions.Action
        /// Number of elements in `entries`.
        let count:Int
        let entries:[String]
        
        public enum Action : UInt, Hashable, Codable {
            case add = 0
            case remote
            case set
        }
    }
}
