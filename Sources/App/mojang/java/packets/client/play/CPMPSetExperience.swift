//
//  CPMPSetExperience.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    struct SetExperience : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_experience
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let experience_bar:Float = try packet.read_float()
            let total_experience:VariableIntegerJava = try packet.read_var_int()
            let level:VariableIntegerJava = try packet.read_var_int()
            return Self(experience_bar: experience_bar, total_experience: total_experience, level: level)
        }
        
        /// Between 0 and 1.
        public let experience_bar:Float
        /// See https://minecraft.fandom.com/wiki/Experience#Leveling_up for Total Experience to Level conversion.
        public let total_experience:VariableIntegerJava
        public let level:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [experience_bar, total_experience, level]
        }
    }
}
