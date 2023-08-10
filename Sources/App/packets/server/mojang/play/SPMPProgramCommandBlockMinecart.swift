//
//  SPMPProgramCommandBlockMinecart.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    struct ProgramCommandBlockMinecart : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let command:String = try packet.read_string()
            let track_output:Bool = try packet.read_bool()
            return Self(entity_id: entity_id, command: command, track_output: track_output)
        }
        
        public let entity_id:VariableInteger
        public let command:String
        public let track_output:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [entity_id, command, track_output]
        }
    }
}
