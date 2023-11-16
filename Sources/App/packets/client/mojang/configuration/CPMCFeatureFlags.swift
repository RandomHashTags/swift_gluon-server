//
//  CPMCFeatureFlags.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    /// Used to enable and disable features, generally experimental ones, on the client.
    ///
    /// As of 1.20.2, the following feature flags are available:
    /// - minecraft:vanilla - enables vanilla features
    /// - minecraft:bundle - enables support for the bundle
    /// - minecraft:trade\_rebalance - enables support for the rebalanced villager trades
    struct FeatureFlags : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.feature_flags
        
        public let total_features:VariableInteger
        public let feature_flags:[Namespace]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var values:[any PacketEncodableMojang] = [total_features]
            values.append(contentsOf: feature_flags)
            return values
        }
    }
}
