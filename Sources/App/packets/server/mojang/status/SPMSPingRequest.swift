//
//  SPMSPingRequest.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Status {
    struct PingRequest : ServerPacketMojangStatusProtocol {
        public static let id:ServerPacketMojangStatus = ServerPacketMojangStatus.ping_request
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let payload:Int64 = try packet.read_long()
            return Self(payload: payload)
        }
        
        /// May be any number. Notchian clients use a system-dependent time value which is counted in milliseconds.
        public let payload:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [payload]
        }
    }
}
