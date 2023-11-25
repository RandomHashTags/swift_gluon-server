//
//  CPMPKeepAlive.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// The server will frequently send out a keep-alive, each containing a random ID. The client must respond with the same payload (see [serverbound Keep Alive](https://wiki.vg/Protocol#Keep_Alive_2 )). If the client does not respond to them for over 30 seconds, the server kicks the client. Vice versa, if the server does not send any keep-alives for 20 seconds, the client will disconnect and yields a "Timed out" exception.
    ///
    /// The Notchian server uses a system-dependent time in milliseconds to generate the keep alive ID value.
    struct KeepAlive : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.keep_alive
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let keep_alive_id:Int64 = try packet.read_long()
            return Self(keep_alive_id: keep_alive_id)
        }
        
        public let keep_alive_id:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [keep_alive_id]
        }
    }
}
