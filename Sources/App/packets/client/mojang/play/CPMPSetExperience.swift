//
//  CPMPSetExperience.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetExperience : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_experience
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let experience_bar:Float = try packet.read_float()
            let total_experience:VariableInteger = try packet.read_var_int()
            let level:VariableInteger = try packet.read_var_int()
            return Self(experience_bar: experience_bar, total_experience: total_experience, level: level)
        }
        
        /// Between 0 and 1.
        public let experience_bar:Float
        /// See https://minecraft.fandom.com/wiki/Experience#Leveling_up for Total Experience to Level conversion.
        public let total_experience:VariableInteger
        public let level:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [experience_bar, total_experience, level]
        }
    }
}
