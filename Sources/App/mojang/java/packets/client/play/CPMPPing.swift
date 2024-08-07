//
//  CPMPPing.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Packet is not used by the Notchian server. When sent to the client, client responds with a Pong packet with the same id.
    struct Ping : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.ping
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.readInt()
            return Self(id: id)
        }
        
        static func server_received(_ client: ClientMojangJava) throws {
            let packet:Self = try client.read_and_parse_mojang_packet()
            let server_response_packet:ServerPacket.Mojang.Java.Play.Pong = ServerPacket.Mojang.Java.Play.Pong(id: packet.id)
            try client.send_packet(server_response_packet)
        }
        
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [id]
        }
    }
}
