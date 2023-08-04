//
//  CPMPSetExperience.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetExperience : ClientPacketMojangPlayProtocol {
        /// Between 0 and 1.
        public let experience_bar:Float
        /// See https://minecraft.fandom.com/wiki/Experience#Leveling_up for Total Experience to Level conversion.
        public let total_experience:Int
        public let level:Int
    }
}
