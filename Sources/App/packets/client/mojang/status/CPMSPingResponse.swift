//
//  CPMSPingResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct PingResponse : ClientPacketMojangStatusProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let payload:Int64 = try packet.read_long()
            return Self(payload: payload)
        }
        
        /// Should be the same as sent by the client.
        public let payload:Int64
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [payload]
        }
    }
}
