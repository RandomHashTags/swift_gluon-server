//
//  SPMPPong.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Response to the clientbound packet ([Ping](https://wiki.vg/Protocol#Ping_.28play.29 )) with the same id.
    struct Pong : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.pong
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.read_int()
            return Self(id: id)
        }
        
        /// `id` is the same as the ping packet.
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [id]
        }
    }
}
