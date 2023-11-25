//
//  SPMLLoginPluginResponse.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Login {
    /// In Notchian server, the maximum data length is 1048576 bytes.
    struct LoginPluginResponse : ServerPacketMojangJavaLoginProtocol {
        public static let id:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login.login_plugin_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_id:VariableInteger = try packet.read_var_int()
            let successful:Bool = try packet.read_bool()
            let data:[UInt8]? = try packet.read_remaining_optional_byte_array()
            return Self(message_id: message_id, successful: successful, data: data)
        }
        
        /// Should match ID from server.
        let message_id:VariableInteger
        /// `true` if the client understood the request, `false` otherwise. When `false`, no payload follows.
        let successful:Bool
        /// Any data, depending on the channel. The length of this array must be inferred from the packet length.
        let data:[UInt8]?
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var values:[any PacketEncodableMojang] = [message_id, successful]
            if let data:[UInt8] = data {
                values.append(contentsOf: data)
            }
            return values
        }
    }
}
