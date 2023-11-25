//
//  CPMPSetBorderCenter.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetBorderCenter : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_border_center
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> ClientPacket.Mojang.Java.Play.SetBorderCenter {
            let x:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            return Self(x: x, z: z)
        }
        
        public let x:Double
        public let z:Double
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [x, z]
        }
    }
}
