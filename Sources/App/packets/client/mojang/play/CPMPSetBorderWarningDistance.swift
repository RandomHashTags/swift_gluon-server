//
//  CPMPSetBorderWarningDistance.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetBorderWarningDistance : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let warning_blocks:VariableInteger = try packet.read_var_int()
            return Self(warning_blocks: warning_blocks)
        }
        
        /// In meters.
        public let warning_blocks:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [warning_blocks]
        }
    }
}
