//
//  SPMPCloseContainer.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// This packet is sent by the client when closing a window.
    ///
    /// Notchian clients send a Close Window packet with Window ID 0 to close their inventory even though there is never an [Open Screen](https://wiki.vg/Protocol#Open_Screen) packet for the inventory.
    struct CloseContainer : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.close_container
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let windowID:UInt8 = try packet.readUnsignedByte()
            return Self(windowID: windowID)
        }
        
        public let windowID:UInt8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID]
        }
    }
}
