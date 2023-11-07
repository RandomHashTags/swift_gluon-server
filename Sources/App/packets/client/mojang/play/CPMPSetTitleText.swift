//
//  CPMPSetTitleText.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetTitleText : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_title_text
        
        public let text:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [text]
        }
    }
}
