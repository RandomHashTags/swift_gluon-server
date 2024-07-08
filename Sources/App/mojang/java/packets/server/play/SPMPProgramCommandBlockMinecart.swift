//
//  SPMPProgramCommandBlockMinecart.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    struct ProgramCommandBlockMinecart : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.program_command_block_minecart
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let command:String = try packet.readString()
            let track_output:Bool = try packet.readBool()
            return Self(entityID: entityID, command: command, track_output: track_output)
        }
        
        public let entityID:VariableIntegerJava
        public let command:String
        public let track_output:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, command, track_output]
        }
    }
}
