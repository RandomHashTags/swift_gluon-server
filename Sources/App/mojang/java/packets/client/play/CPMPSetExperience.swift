//
//  CPMPSetExperience.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetExperience : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_experience
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let experienceBar:Float = try packet.readFloat()
            let totalExperience:VariableIntegerJava = try packet.readVarInt()
            let level:VariableIntegerJava = try packet.readVarInt()
            return Self(experienceBar: experienceBar, totalExperience: totalExperience, level: level)
        }
        
        /// Between 0 and 1.
        public let experienceBar:Float
        /// See https://minecraft.fandom.com/wiki/Experience#Leveling_up for Total Experience to Level conversion.
        public let totalExperience:VariableIntegerJava
        public let level:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [experienceBar, totalExperience, level]
        }
    }
}
