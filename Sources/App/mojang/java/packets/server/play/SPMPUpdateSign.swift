//
//  SPMPUpdateSign.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// This message is sent from the client to the server when the “Done” button is pushed after placing a sign.
    ///
    /// The server only accepts this packet after [Open Sign Editor](https://wiki.vg/Protocol#Open_Sign_Editor ), otherwise this packet is silently ignored.
    struct UpdateSign : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.update_sign
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let is_front_text:Bool = try packet.read_bool()
            let line_1:String = try packet.read_string()
            let line_2:String = try packet.read_string()
            let line_3:String = try packet.read_string()
            let line_4:String = try packet.read_string()
            return Self(location: location, is_front_text: is_front_text, line_1: line_1, line_2: line_2, line_3: line_3, line_4: line_4)
        }
        
        /// Block Coordinates.
        public let location:PositionPacketMojang
        /// Whether the updated text is in front or on the back of the sign.
        public let is_front_text:Bool
        public let line_1:String
        public let line_2:String
        public let line_3:String
        public let line_4:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [
                location,
                is_front_text,
                line_1,
                line_2,
                line_3,
                line_4
            ]
        }
    }
}
