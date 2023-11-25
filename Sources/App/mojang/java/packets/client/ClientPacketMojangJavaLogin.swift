//
//  ClientPacketMojangJavaLogin.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java {
    enum Login : UInt8, PacketGameplayID {
        case disconnect = 0
        case encryption_request = 1
        case login_success
        case set_compression
        case login_plugin_request
        
        var packet : any ClientPacketMojangJavaProtocol.Type {
            switch self {
            case .disconnect:           return ClientPacket.Mojang.Java.Login.Disconnect.self
            case .encryption_request:   return ClientPacket.Mojang.Java.Login.EncryptionRequest.self
            case .login_success:        return ClientPacket.Mojang.Java.Login.LoginSuccess.self
            case .set_compression:      return ClientPacket.Mojang.Java.Login.SetCompression.self
            case .login_plugin_request: return ClientPacket.Mojang.Java.Login.LoginPluginRequest.self
            }
        }
    }
}
