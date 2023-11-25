//
//  CPMJConfiguration.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacket.Mojang.Java {
    enum Configuration : UInt8, PacketGameplayID {
        case plugin_message
        case disconnect
        case finish_configuration
        case keep_alive
        case ping
        case registry_data
        case resource_pack
        case feature_flags
        case update_tags
        
        public var packet : any ClientPacketMojangJavaConfigurationProtocol.Type {
            switch self {
            case .plugin_message:       return ClientPacket.Mojang.Java.Configuration.PluginMessage.self
            case .disconnect:           return ClientPacket.Mojang.Java.Configuration.Disconnect.self
            case .finish_configuration: return ClientPacket.Mojang.Java.Configuration.FinishConfiguration.self
            case .keep_alive:           return ClientPacket.Mojang.Java.Configuration.KeepAlive.self
            case .ping:                 return ClientPacket.Mojang.Java.Configuration.Ping.self
            case .registry_data:        return ClientPacket.Mojang.Java.Configuration.RegistryData.self
            case .resource_pack:        return ClientPacket.Mojang.Java.Configuration.ResourcePack.self
            case .feature_flags:        return ClientPacket.Mojang.Java.Configuration.FeatureFlags.self
            case .update_tags:          return ClientPacket.Mojang.Java.Configuration.UpdateTags.self
            }
        }
    }
}
