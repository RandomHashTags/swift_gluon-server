//
//  CPMPPing.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Packet is not used by the Notchian server. When sent to the client, client responds with a Pong packet with the same id.
    struct Ping : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.ping
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.read_int()
            return Self(id: id)
        }
        
        public static func server_received(_ client: ServerMojangClient) throws {
            let packet:Self = try client.read_and_parse_mojang_packet()
            let server_response_packet:ServerPacket.Mojang.Java.Play.Pong = ServerPacket.Mojang.Java.Play.Pong(id: packet.id)
            try client.send_packet(server_response_packet)
        }
        
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [id]
        }
    }
}
