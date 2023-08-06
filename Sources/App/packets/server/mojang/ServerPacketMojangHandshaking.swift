//
//  ServerPacketMojangHandshaking.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public enum ServerPacketMojangHandshaking : UInt8, PacketGameplayID {
    case handshake = 0
    case legacy_server_list_ping = 254
    
    public var packet : any ServerPacketMojangHandshakingProtocol.Type {
        switch self {
        case .handshake:               return ServerPacketMojang.Handshaking.Handshake.self
        case .legacy_server_list_ping: return ServerPacketMojang.Handshaking.LegacyServerListPing.self
        }
    }
}
