//
//  SPMSPingRequest.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Status {
    struct PingRequest : ServerPacketMojangStatusProtocol {
        /// May be any number. Notchian clients use a system-dependent time value which is counted in milliseconds.
        public let payload:Int
        
        public func get_encoded_values() -> [PacketByteEncodableMojang?] {
            return [payload]
        }
    }
}
