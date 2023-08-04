//
//  CPMSPingResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct PingResponse : ClientPacketMojangStatusProtocol {
        /// Should be the same as sent by the client.
        public let payload:UInt64
    }
}
