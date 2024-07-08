//
//  CPMJCDisconnect.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Configuration {
    struct Disconnect : ClientPacket.Mojang.Java.ConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.disconnect
        
        /// The reason why the player was disconnected.
        public let reason:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [reason]
        }
    }
}
