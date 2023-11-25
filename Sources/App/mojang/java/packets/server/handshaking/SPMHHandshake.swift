//
//  SPMHHandshake.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Handshaking {
    /// This causes the server to switch into the target state.
    struct Handshake : ServerPacketMojangJavaHandshakingProtocol {
        public static let id:ServerPacket.Mojang.Java.Handshaking = ServerPacket.Mojang.Java.Handshaking.handshake
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let protocol_version:MinecraftProtocolJavaVersion = try packet.read_enum()
            let server_address:String = try packet.read_string()
            let server_port:UInt16 = try packet.read_unsigned_short()
            let next_state:State = try packet.read_enum()
            return Handshake(protocol_version: protocol_version, server_address: server_address, server_port: server_port, next_state: next_state)
        }
        
        /// See https://wiki.vg/Protocol_version_numbers .
        public let protocol_version:MinecraftProtocolJavaVersion
        /// Hostname or IP, e.g. localhost or 127.0.0.1, that was used to connect. The Notchian server does not use this information.
        /// > Note: SRV records are a simple redirect, e.g. if \_minecraft.\_tcp.example.com points to mc.example.org, users connecting to example.com will provide example.org as server address in addition to connecting to it.
        public let server_address:String
        /// Default is 25565. The Notchian server does not use this information.
        public let server_port:UInt16
        public let next_state:State
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [protocol_version, server_address, server_port, next_state]
        }
        
        public enum State : Int, Hashable, Codable, PacketEncodableMojang {
            case status = 1
            case login  = 2
        }
    }
}
