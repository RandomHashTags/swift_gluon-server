//
//  CPMPSetBorderWarningDelay.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetBorderWarningDelay : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_border_warning_delay
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let warningTime:VariableIntegerJava = try packet.readVarInt()
            return Self(warningTime: warningTime)
        }
        
        /// In seconds as set by `/worldborder warning time`.
        public let warningTime:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [warningTime]
        }
    }
}
