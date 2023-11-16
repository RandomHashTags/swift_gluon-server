//
//  ClientPacketMojangConfiguration.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public enum ClientPacketMojangConfiguration : UInt8, PacketGameplayID {
    case plugin_message
    case disconnect
    case finish_configuration
    case keep_alive
    case ping
    case registry_data
    case resource_pack
    case feature_flags
    case update_tags
    
    public var packet : any ClientPacketMojangConfigurationProtocol.Type {
        switch self {
        case .plugin_message:       return ClientPacketMojang.Configuration.PluginMessage.self
        case .disconnect:           return ClientPacketMojang.Configuration.Disconnect.self
        case .finish_configuration: return ClientPacketMojang.Configuration.FinishConfiguration.self
        case .keep_alive:           return ClientPacketMojang.Configuration.KeepAlive.self
        case .ping:                 return ClientPacketMojang.Configuration.Ping.self
        case .registry_data:        return ClientPacketMojang.Configuration.RegistryData.self
        case .resource_pack:        return ClientPacketMojang.Configuration.ResourcePack.self
        case .feature_flags:        return ClientPacketMojang.Configuration.FeatureFlags.self
        case .update_tags:          return ClientPacketMojang.Configuration.UpdateTags.self
        }
    }
}
