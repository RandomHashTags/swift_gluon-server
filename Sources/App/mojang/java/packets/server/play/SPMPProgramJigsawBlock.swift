//
//  SPMPProgramJigsawBlock.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Sent when Done is pressed on the Jigsaw Block interface.
    struct ProgramJigsawBlock : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.program_jigsaw_block
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let name:Namespace = try packet.readIdentifier()
            let target:Namespace = try packet.readIdentifier()
            let pool:Namespace = try packet.readIdentifier()
            let final_state:String = try packet.readString()
            let joint_type:String = try packet.readString()
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
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [location, name, target, pool, final_state, joint_type]
        }
    }
}
