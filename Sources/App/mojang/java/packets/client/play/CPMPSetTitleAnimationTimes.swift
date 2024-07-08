//
//  CPMPSetTitleAnimationTimes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetTitleAnimationTimes : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_title_animation_times
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let fadeIn:Int32 = try packet.readInt()
            let stay:Int32 = try packet.readInt()
            let fadeOut:Int32 = try packet.readInt()
            return Self(fadeIn: fadeIn, stay: stay, fadeOut: fadeOut)
        }
        
        /// Ticks to spend fading in.
        public let fadeIn:Int32
        /// Ticks to keep the title displayed.
        public let stay:Int32
        /// Ticks to spend fading out, not when to start fading out.
        public let fadeOut:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [fadeIn, stay, fadeOut]
        }
    }
}
