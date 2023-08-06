//
//  SPMHHandshake.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Handshaking {
    /// This causes the server to switch into the target state.
    struct Handshake : ServerPacketMojangHandshakingProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let protocol_version_raw_value:Int = try packet.read_var_int()
            guard let protocol_version:MinecraftProtocolVersion = MinecraftProtocolVersion.init(rawValue: protocol_version_raw_value) else {
                throw ServerPacketMojangErrors.ProtocolVersion.doesnt_exist(id: protocol_version_raw_value)
            }
            let server_address:String = try packet.read_string()
            let server_port:Int = try packet.read_short()
            let next_state_raw_value:Int = try packet.read_var_int()
            guard let next_state:ServerPacketMojang.Status = ServerPacketMojang.Status.init(rawValue: next_state_raw_value) else {
                throw ServerPacketMojangErrors.Status.doesnt_exist(id: next_state_raw_value)
            }
            return Handshake(protocol_version: protocol_version, server_address: server_address, server_port: server_port, next_state: next_state)
        }
        
        /// See https://wiki.vg/Protocol_version_numbers .
        public let protocol_version:MinecraftProtocolVersion
        /// Hostname or IP, e.g. localhost or 127.0.0.1, that was used to connect. The Notchian server does not use this information.
        /// > Note: SRV records are a simple redirect, e.g. if \_minecraft.\_tcp.example.com points to mc.example.org, users connecting to example.com will provide example.org as server address in addition to connecting to it.
        public let server_address:String
        /// Default is 25565. The Notchian server does not use this information.
        public let server_port:Int
        public let next_state:ServerPacketMojang.Status
        
        public func get_encoded_values() -> [PacketByteEncodableMojang?] {
            return [protocol_version, server_address, server_port, next_state]
        }
    }
}
