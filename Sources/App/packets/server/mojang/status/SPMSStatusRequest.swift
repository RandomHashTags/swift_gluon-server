//
//  SPMSStatusRequest.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Status {
    /// The status can only be requested once immediately after the handshake, before any ping. The server won't respond otherwise.
    struct StatusRequest : ServerPacketMojangStatusProtocol {
        public static let id:ServerPacketMojangStatus = ServerPacketMojangStatus.status_request
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            return StatusRequest()
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return []
        }
    }
}
