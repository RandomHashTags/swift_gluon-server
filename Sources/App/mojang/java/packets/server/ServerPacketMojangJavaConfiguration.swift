//
//  ServerPacketMojangJavaConfiguration.swift
//  
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ServerPacket.Mojang.Java {
    enum Configuration : UInt8, PacketGameplayID {
        case client_information
        case plugin_message
        case finish_configuration
        case keep_alive
        case pong
        case resource_pack_response
        
        public var packet : any ServerPacketMojangJavaConfigurationProtocol.Type {
            switch self {
            case .client_information:     return ServerPacket.Mojang.Java.Configuration.ClientInformation.self
            case .plugin_message:         return ServerPacket.Mojang.Java.Configuration.PluginMessage.self
            case .finish_configuration:   return ServerPacket.Mojang.Java.Configuration.FinishConfiguration.self
            case .keep_alive:             return ServerPacket.Mojang.Java.Configuration.KeepAlive.self
            case .pong:                   return ServerPacket.Mojang.Java.Configuration.Pong.self
            case .resource_pack_response: return ServerPacket.Mojang.Java.Configuration.ResourcePackResponse.self
            }
        }
    }
}
