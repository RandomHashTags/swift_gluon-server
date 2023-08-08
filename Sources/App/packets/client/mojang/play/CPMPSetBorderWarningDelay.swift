//
//  CPMPSetBorderWarningDelay.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetBorderWarningDelay : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let warning_time:VariableInteger = try packet.read_var_int()
            return Self(warning_time: warning_time)
        }
        
        /// In seconds as set by `/worldborder warning time`.
        public let warning_time:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [warning_time]
        }
    }
}
