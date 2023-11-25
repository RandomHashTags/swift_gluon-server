//
//  CPMJSPingResponse.swift
//
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Status {
    struct PingResponse : ClientPacketMojangJavaStatusProtocol {
        public static let id:ClientPacket.Mojang.Java.Status = ClientPacket.Mojang.Java.Status.ping_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let payload:Int64 = try packet.read_long()
            return Self(payload: payload)
        }
        
        /// Should be the same as sent by the client.
        public let payload:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [payload]
        }
    }
}
