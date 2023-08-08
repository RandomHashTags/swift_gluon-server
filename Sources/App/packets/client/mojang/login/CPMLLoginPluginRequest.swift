//
//  CPMLLoginPluginRequest.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// Used to implement a custom handshaking flow together with Login Plugin Response.
    ///
    /// Unlike plugin messages in "play" mode, these messages follow a lock-step request/response scheme, where the client is expected to respond to a request indicating whether it understood. The notchian client always responds that it hasn't understood, and sends an empty payload.
    ///
    /// In Notchian client, the maximum data length is 1048576 bytes.
    struct LoginPluginRequest : ClientPacketMojangLoginProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_id:VariableInteger = try packet.read_var_int()
            let channel:Namespace = try packet.read_identifier()
            let data:[UInt8] = try packet.read_remaining_byte_array()
            return Self(message_id: message_id, channel: channel, data: data)
        }
        
        public let message_id:VariableInteger
        public let channel:Namespace
        public let data:[UInt8]
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [message_id, channel]
            array.append(contentsOf: data)
            return array
        }
    }
}
