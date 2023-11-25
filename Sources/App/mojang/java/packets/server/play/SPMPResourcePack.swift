//
//  SPMPResourcePack.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    struct ResourcePack : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.resource_pack
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let result:ResourcePack.Result = try packet.read_enum()
            return Self(result: result)
        }
        
        public let result:ResourcePack.Result
        
        public enum Result : Int, Hashable, Codable, PacketEncodableMojangJava {
            case successfully_loaded
            case declined
            case failed_download
            case accepted
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [result]
        }
    }
}
