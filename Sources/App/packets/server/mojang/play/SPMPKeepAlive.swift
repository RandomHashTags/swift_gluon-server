//
//  SPMPKeepAlive.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// The server will frequently send out a keep-alive (see [Clientbound Keep Alive](https://wiki.vg/Protocol#Keep_Alive )), each containing a random ID. The client must respond with the same packet.
    struct KeepAlive : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let keep_alive_id:Int64 = try packet.read_long()
            return Self(keep_alive_id: keep_alive_id)
        }
        
        public let keep_alive_id:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [keep_alive_id]
        }
    }
}
