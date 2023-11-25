//
//  SPMJLLoginAcknowledged.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Login {
    /// Acknowledgement to the [Login Success](https://wiki.vg/Protocol#Login_Success) packet sent by the server.
    ///
    /// This packet switches the connection state to [configuration](https://wiki.vg/Protocol#Configuration).
    struct LoginAcknowledged : ServerPacketMojangJavaLoginProtocol {
        public static let id:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login.login_acknowledged
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            return Self()
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return []
        }
    }
}
