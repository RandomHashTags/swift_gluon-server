//
//  SPMPProgramJigsawBlock.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when Done is pressed on the Jigsaw Block interface.
    struct ProgramJigsawBlock : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.program_jigsaw_block
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let name:Namespace = try packet.read_identifier()
            let target:Namespace = try packet.read_identifier()
            let pool:Namespace = try packet.read_identifier()
            let final_state:String = try packet.read_string()
            let joint_type:String = try packet.read_string()
            return Self(location: location, name: name, target: target, pool: pool, final_state: final_state, joint_type: joint_type)
        }
        
        /// Block entity location
        public let location:PositionPacketMojang
        public let name:Namespace
        public let target:Namespace
        public let pool:Namespace
        /// "Turns into" on the GUI, `final_state` in NBT.
        public let final_state:String
        /// `rollable` if the attached piece can be rotated, else `aligned`.
        public let joint_type:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [location, name, target, pool, final_state, joint_type]
        }
    }
}
