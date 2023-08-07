//
//  SPMSPingRequest.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Status {
    struct PingRequest : ServerPacketMojangStatusProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let payload:Int = try packet.read_long()
            return Self(payload: payload)
        }
        
        /// May be any number. Notchian clients use a system-dependent time value which is counted in milliseconds.
        public let payload:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [payload]
        }
    }
}
