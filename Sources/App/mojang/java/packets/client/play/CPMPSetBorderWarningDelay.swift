//
//  CPMPSetBorderWarningDelay.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    struct SetBorderWarningDelay : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_border_warning_delay
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let warning_time:VariableIntegerJava = try packet.read_var_int()
            return Self(warning_time: warning_time)
        }
        
        /// In seconds as set by `/worldborder warning time`.
        public let warning_time:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [warning_time]
        }
    }
}
