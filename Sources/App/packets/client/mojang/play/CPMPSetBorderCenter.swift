//
//  CPMPSetBorderCenter.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetBorderCenter : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> ClientPacketMojang.Play.SetBorderCenter {
            let x:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            return Self(x: x, z: z)
        }
        
        public let x:Double
        public let z:Double
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [x, z]
        }
    }
}
