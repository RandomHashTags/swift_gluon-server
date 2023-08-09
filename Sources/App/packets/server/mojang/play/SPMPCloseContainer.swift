//
//  SPMPCloseContainer.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// This packet is sent by the client when closing a window.
    ///
    /// Notchian clients send a Close Window packet with Window ID 0 to close their inventory even though there is never an [Open Screen](https://wiki.vg/Protocol#Open_Screen) packet for the inventory.
    struct CloseContainer : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:UInt8 = try packet.read_unsigned_byte()
            return Self(window_id: window_id)
        }
        
        public let window_id:UInt8
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [window_id]
        }
    }
}
