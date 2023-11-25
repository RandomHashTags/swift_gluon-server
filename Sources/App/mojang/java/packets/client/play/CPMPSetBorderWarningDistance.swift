//
//  CPMPSetBorderWarningDistance.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct SetBorderWarningDistance : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_border_warning_distance
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let warning_blocks:VariableIntegerJava = try packet.read_var_int()
            return Self(warning_blocks: warning_blocks)
        }
        
        /// In meters.
        public let warning_blocks:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [warning_blocks]
        }
    }
}
