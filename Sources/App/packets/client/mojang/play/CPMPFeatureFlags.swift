//
//  CPMPFeatureFlags.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Used to enable and disable features, generally experimental ones, on the client.
    ///
    /// As of 1.20.1, the following feature flags are available:
    /// - `minecraft:vanilla` - enables vanilla features
    /// - `minecraft:bundle` - enables support for the bundle
    struct FeatureFlags : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let total_features:VariableInteger = try packet.read_var_int()
            let feature_flags:[Namespace] = try packet.read_packet_decodable_array(count: total_features)
            return Self(total_features: total_features, feature_flags: feature_flags)
        }
        
        public let total_features:VariableInteger
        public let feature_flags:[Namespace]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[any PacketEncodableMojang] = [total_features]
            array.append(contentsOf: feature_flags)
            return array
        }
    }
}
