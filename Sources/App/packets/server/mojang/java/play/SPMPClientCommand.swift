//
//  SPMPClientCommand.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    struct ClientCommand : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.client_command
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let action:ClientCommand.Action = try packet.read_enum()
            return Self(action: action)
        }
        
        public let action:ClientCommand.Action
        
        public enum Action : Int, Hashable, Codable, PacketEncodableMojang {
            /// Sent when the client is ready to complete login and when the client is ready to respawn after death.
            case perform_respawn = 0
            /// Sent when the client opens the Statistics menu.
            case request_stats = 1
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [action]
        }
    }
}
