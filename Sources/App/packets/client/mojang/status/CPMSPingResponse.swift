//
//  CPMSPingResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct PingResponse : ClientPacketMojangStatusProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let payload:Int = try packet.read_long()
            return Self(payload: payload)
        }
        
        /// Should be the same as sent by the client.
        public let payload:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [payload]
        }
    }
}
