//
//  CPMCDisconnect.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    struct Disconnect : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.disconnect
        
        /// The reason why the player was disconnected.
        public let reason:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [reason]
        }
    }
}
