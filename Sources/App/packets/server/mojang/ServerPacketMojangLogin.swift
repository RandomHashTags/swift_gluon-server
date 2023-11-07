//
//  ServerPacketMojangLogin.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

public enum ServerPacketMojangLogin : UInt8, PacketGameplayID {
    case login_start         = 0
    case encryption_response = 1
    case login_plugin_response
    case login_acknowledged
    
    public var packet : any ServerPacketMojangLoginProtocol.Type {
        switch self {
        case .login_start:           return ServerPacketMojang.Login.LoginStart.self
        case .encryption_response:   return ServerPacketMojang.Login.EncryptionResponse.self
        case .login_plugin_response: return ServerPacketMojang.Login.LoginPluginResponse.self
        case .login_acknowledged:    return ServerPacketMojang.Login.LoginAcknowledged.self
        }
    }
}
