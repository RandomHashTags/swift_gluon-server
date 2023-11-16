//
//  SPMCPong.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ServerPacketMojang.Configuration {
    /// Response to the clientbound packet ([Ping](https://wiki.vg/Protocol#Ping_.28configuration.29 )) with the same id.
    struct Pong : ServerPacketMojangConfigurationProtocol {
        public static let id:ServerPacketMojangConfiguration = ServerPacketMojangConfiguration.pong
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.read_int()
            return Self(id: id)
        }
        
        /// `id` is the same as the ping packet.
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [id]
        }
    }
}
