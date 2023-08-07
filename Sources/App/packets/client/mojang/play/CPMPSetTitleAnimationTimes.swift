//
//  CPMPSetTitleAnimationTimes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetTitleAnimationTimes : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let fade_in:Int = try packet.read_int()
            let stay:Int = try packet.read_int()
            let fade_out:Int = try packet.read_int()
            return Self(fade_in: fade_in, stay: stay, fade_out: fade_out)
        }
        
        /// Ticks to spend fading in.
        public let fade_in:Int
        /// Ticks to keep the title displayed.
        public let stay:Int
        /// Ticks to spend fading out, not when to start fading out.
        public let fade_out:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [fade_in, stay, fade_out]
        }
    }
}
