//
//  SPMLLoginStart.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

public extension ServerPacketMojang.Login {
    struct LoginStart : ServerPacketMojangLoginProtocol {
        public static let id:ServerPacketMojangLogin = ServerPacketMojangLogin.login_start
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let name:String = try packet.read_string()
            let player_uuid:UUID = try packet.read_uuid()
            return Self(name: name, player_uuid: player_uuid)
        }
        
        /// Player's Username.
        public let name:String
        /// The UUID of the player logging in. Unused by the Notchian server.
        public let player_uuid:UUID
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [name, player_uuid]
        }
    }
}
