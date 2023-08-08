//
//  CPMPServerData.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct ServerData : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_of_the_day:ChatPacketMojang = try packet.read_packet_decodable()
            let has_icon:Bool = try packet.read_bool()
            let icon:[UInt8]? = has_icon ? try packet.read_byte_array(bytes: packet.length) : nil // TODO: fix
            let enforces_secure_chat:Bool = try packet.read_bool()
            return Self(message_of_the_day: message_of_the_day, has_icon: has_icon, icon: icon, enforces_secure_chat: enforces_secure_chat)
        }
        
        public let message_of_the_day:ChatPacketMojang
        public let has_icon:Bool
        public let icon:[UInt8]?
        public let enforces_secure_chat:Bool
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [message_of_the_day, has_icon]
            array.append(contentsOf: array)
            array.append(enforces_secure_chat)
            return array
        }
    }
}
