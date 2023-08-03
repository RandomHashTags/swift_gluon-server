//
//  ClientPacketMojangLogin.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public enum ClientPacketMojangLogin : UInt, PacketGameplayID {
    case disconnect = 0
    case encryption_request = 1
    case login_success
    case set_compression
    case login_plugin_request
    
    var packet : any ClientPacketMojangProtocol.Type {
        switch self {
        case .disconnect:           return ClientPacketMojang.Login.Disconnect.self
        case .encryption_request:   return ClientPacketMojang.Login.EncryptionRequest.self
        case .login_success:        return ClientPacketMojang.Login.LoginSuccess.self
        case .set_compression:      return ClientPacketMojang.Login.SetCompression.self
        case .login_plugin_request: return ClientPacketMojang.Login.LoginPluginRequest.self
        }
    }
}
