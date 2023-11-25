//
//  ServerPacketMojangJavaLogin.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

public extension ServerPacket.Mojang.Java {
    enum Login : UInt8, PacketGameplayID {
        case login_start         = 0
        case encryption_response = 1
        case login_plugin_response
        case login_acknowledged
        
        public var packet : any ServerPacketMojangJavaLoginProtocol.Type {
            switch self {
            case .login_start:           return ServerPacket.Mojang.Java.Login.LoginStart.self
            case .encryption_response:   return ServerPacket.Mojang.Java.Login.EncryptionResponse.self
            case .login_plugin_response: return ServerPacket.Mojang.Java.Login.LoginPluginResponse.self
            case .login_acknowledged:    return ServerPacket.Mojang.Java.Login.LoginAcknowledged.self
            }
        }
    }
}
