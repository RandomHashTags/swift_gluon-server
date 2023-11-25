//
//  ServerPacketMojangJavaHandshaking.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

extension ServerPacket.Mojang.Java {
    enum Handshaking : UInt8, PacketGameplayID {
        case handshake = 0
        case legacy_server_list_ping = 254
        
        var packet : any ServerPacketMojangJavaHandshakingProtocol.Type {
            switch self {
            case .handshake:               return ServerPacket.Mojang.Java.Handshaking.Handshake.self
            case .legacy_server_list_ping: return ServerPacket.Mojang.Java.Handshaking.LegacyServerListPing.self
            }
        }
    }
}
