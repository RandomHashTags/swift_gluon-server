//
//  ServerPacketMojangConfiguration.swift
//  
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public enum ServerPacketMojangConfiguration : UInt8, PacketGameplayID {
    case client_information
    case plugin_message
    case finish_configuration
    case keep_alive
    case pong
    case resource_pack_response
    
    public var packet : any ServerPacketMojangConfigurationProtocol.Type {
        switch self {
        case .client_information:     return ServerPacketMojang.Configuration.ClientInformation.self
        case .plugin_message:         return ServerPacketMojang.Configuration.PluginMessage.self
        case .finish_configuration:   return ServerPacketMojang.Configuration.FinishConfiguration.self
        case .keep_alive:             return ServerPacketMojang.Configuration.KeepAlive.self
        case .pong:                   return ServerPacketMojang.Configuration.Pong.self
        case .resource_pack_response: return ServerPacketMojang.Configuration.ResourcePackResponse.self
        }
    }
}
