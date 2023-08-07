//
//  CPMLDisconnect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    struct Disconnect : ClientPacketMojangLoginProtocol {
        /// The reason why the player was disconnected.
        public let reason:ChatPacketMojang
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [reason]
        }
    }
}
