//
//  SPMJLLoginStart.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Login {
    struct LoginStart : ServerPacketMojangJavaLoginProtocol {
        public static let id:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login.login_start
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let name:String = try packet.readString()
            let player_uuid:UUID = try packet.readUUID()
            return Self(name: name, player_uuid: player_uuid)
        }
        
        /// Player's Username.
        public let name:String
        /// The UUID of the player logging in. Unused by the Notchian server.
        public let player_uuid:UUID
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [name, player_uuid]
        }
    }
}
