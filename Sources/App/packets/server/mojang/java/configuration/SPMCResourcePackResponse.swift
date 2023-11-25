//
//  SPMCResourcePackResponse.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Configuration {
    struct ResourcePackResponse : ServerPacketMojangJavaConfigurationProtocol {
        public static let id:ServerPacket.Mojang.Java.Configuration = ServerPacket.Mojang.Java.Configuration.resource_pack_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let result:Result = try packet.read_enum()
            return Self(result: result)
        }
        
        public let result:Result
        
        public enum Result : Int, Hashable, Codable, PacketEncodableMojang {
            case successfully_loaded
            case declined
            case failed_download
            case accepted
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [result]
        }
    }
}
