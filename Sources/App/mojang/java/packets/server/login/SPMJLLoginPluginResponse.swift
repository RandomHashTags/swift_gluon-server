//
//  SPMJLLoginPluginResponse.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Login {
    /// In Notchian server, the maximum data length is 1048576 bytes.
    struct LoginPluginResponse : ServerPacketMojangJavaLoginProtocol {
        public static let id:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login.login_plugin_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_id:VariableIntegerJava = try packet.readVarInt()
            let successful:Bool = try packet.readBool()
            let data:[UInt8]? = try packet.readRemainingOptionalByteArray()
            return Self(message_id: message_id, successful: successful, data: data)
        }
        
        /// Should match ID from server.
        let message_id:VariableIntegerJava
        /// `true` if the client understood the request, `false` otherwise. When `false`, no payload follows.
        let successful:Bool
        /// Any data, depending on the channel. The length of this array must be inferred from the packet length.
        let data:[UInt8]?
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var values:[any PacketEncodableMojangJava] = [message_id, successful]
            if let data:[UInt8] = data {
                values.append(contentsOf: data)
            }
            return values
        }
    }
}
