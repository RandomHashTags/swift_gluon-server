//
//  SPMPProgramCommandBlock.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    struct ProgramCommandBlock : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let command:String = try packet.read_string()
            let mode:ProgramCommandBlock.Mode = try packet.read_enum()
            let flags:Int8 = try packet.read_byte()
            return Self(location: location, command: command, mode: mode, flags: flags)
        }
        
        public let location:PositionPacketMojang
        public let command:String
        public let mode:ProgramCommandBlock.Mode
        /// 0x01: Track Output (if false, the output of the previous command will not be stored within the command block); 0x02: Is conditional; 0x04: Automatic.
        public let flags:Int8
        
        public enum Mode : Int, Hashable, Codable, PacketEncodableMojang {
            case sequence
            case auto
            case redstone
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [location, command, mode, flags]
        }
    }
}
