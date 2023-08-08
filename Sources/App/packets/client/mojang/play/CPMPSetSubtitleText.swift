//
//  CPMPSetSubtitleText.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetSubtitleText : ClientPacketMojangPlayProtocol {
        public let text:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [text]
        }
    }
}
