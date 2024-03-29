//
//  CPMPSetTitleAnimationTimes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetTitleAnimationTimes : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_title_animation_times
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let fade_in:Int32 = try packet.read_int()
            let stay:Int32 = try packet.read_int()
            let fade_out:Int32 = try packet.read_int()
            return Self(fade_in: fade_in, stay: stay, fade_out: fade_out)
        }
        
        /// Ticks to spend fading in.
        public let fade_in:Int32
        /// Ticks to keep the title displayed.
        public let stay:Int32
        /// Ticks to spend fading out, not when to start fading out.
        public let fade_out:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [fade_in, stay, fade_out]
        }
    }
}
