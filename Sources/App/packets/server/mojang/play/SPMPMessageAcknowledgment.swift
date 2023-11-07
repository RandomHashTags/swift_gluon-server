//
//  SPMPMessageAcknowledgment.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    struct MessageAcknowledgment : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.message_acknowledgement
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_count:VariableInteger = try packet.read_var_int()
            return Self(message_count: message_count)
        }
        
        public let message_count:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [message_count]
        }
    }
}
