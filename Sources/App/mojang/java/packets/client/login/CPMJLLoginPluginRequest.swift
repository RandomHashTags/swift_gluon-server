//
//  CPMJLLoginPluginRequest.swift
//
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Login {
    /// Used to implement a custom handshaking flow together with Login Plugin Response.
    ///
    /// Unlike plugin messages in "play" mode, these messages follow a lock-step request/response scheme, where the client is expected to respond to a request indicating whether it understood. The notchian client always responds that it hasn't understood, and sends an empty payload.
    ///
    /// In Notchian client, the maximum data length is 1048576 bytes.
    struct LoginPluginRequest : ClientPacketMojangJavaLoginProtocol {
        public static let id:ClientPacket.Mojang.Java.Login = ClientPacket.Mojang.Java.Login.login_plugin_request
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_id:VariableIntegerJava = try packet.read_var_int()
            let channel:Namespace = try packet.read_identifier()
            let data:[UInt8] = try packet.read_remaining_byte_array()
            return Self(message_id: message_id, channel: channel, data: data)
        }
        
        public let message_id:VariableIntegerJava
        public let channel:Namespace
        public let data:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [message_id, channel]
            array.append(contentsOf: data)
            return array
        }
    }
}
