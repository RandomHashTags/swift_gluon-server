//
//  SPMPJigsawGenerate.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when Generate is pressed on the [Jigsaw Block](https://minecraft.fandom.com/wiki/Jigsaw_Block) interface.
    struct JigsawGenerate : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let levels:VariableInteger = try packet.read_var_int()
            let keep_jigsaws:Bool = try packet.read_bool()
            return Self(location: location, levels: levels, keep_jigaws: keep_jigsaws)
        }
        
        /// Block entity location.
        public let location:PositionPacketMojang
        /// Value of the levels slider/max depth to generate.
        public let levels:VariableInteger
        public let keep_jigaws:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [location, levels, keep_jigaws]
        }
    }
}
