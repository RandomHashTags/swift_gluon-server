//
//  CPMPSetBorderSize.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetBorderSize : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_border_size
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let diameter:Double = try packet.readDouble()
            return Self(diameter: diameter)
        }
        
        /// Length of a single side of the world border, in meters.
        public let diameter:Double
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [diameter]
        }
    }
}
