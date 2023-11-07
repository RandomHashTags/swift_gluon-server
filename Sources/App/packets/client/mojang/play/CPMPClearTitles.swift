//
//  CPMPClearTitles.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Clear the client's current title information, with the option to also reset it.
    struct ClearTitles : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.clear_titles
        
        public let reset:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [reset]
        }
    }
}
