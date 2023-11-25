//
//  SPMPProgramStructureBlock.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// !
    ///
    /// The Notchian client uses `update data` to indicate no special action should be taken (i.e. the done button).
    struct ProgramStructureBlock : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.program_structure_block
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let action:ProgramStructureBlock.Action = try packet.read_enum()
            let mode:ProgramStructureBlock.Mode = try packet.read_enum()
            let name:String = try packet.read_string()
            let offset_x:Int8 = try packet.read_byte()
            let offset_y:Int8 = try packet.read_byte()
            let offset_z:Int8 = try packet.read_byte()
            let size_x:Int8 = try packet.read_byte()
            let size_y:Int8 = try packet.read_byte()
            let size_z:Int8 = try packet.read_byte()
            let mirror:ProgramStructureBlock.Mirror = try packet.read_enum()
            let rotation:ProgramStructureBlock.Rotation = try packet.read_enum()
            let metadata:String = try packet.read_string()
            let integrity:Float = try packet.read_float()
            let seed:VariableLongJava = try packet.read_var_long()
            let flags:Int8 = try packet.read_byte()
            return Self(location: location, action: action, mode: mode, name: name, offset_x: offset_x, offset_y: offset_y, offset_z: offset_z, size_x: size_x, size_y: size_y, size_z: size_z, mirror: mirror, rotation: rotation, metadata: metadata, integrity: integrity, seed: seed, flags: flags)
        }
        
        /// Block entity location.
        public let location:PositionPacketMojang
        /// An additional action to perform beyond simply saving the given data.
        public let action:ProgramStructureBlock.Action
        public let mode:ProgramStructureBlock.Mode
        public let name:String
        /// Between -48 and 48.
        public let offset_x:Int8
        /// Between -48 and 48.
        public let offset_y:Int8
        /// Between -48 and 48.
        public let offset_z:Int8
        /// Between 0 and 48.
        public let size_x:Int8
        /// Between 0 and 48.
        public let size_y:Int8
        /// Between 0 and 48.
        public let size_z:Int8
        public let mirror:ProgramStructureBlock.Mirror
        public let rotation:ProgramStructureBlock.Rotation
        public let metadata:String
        /// Between 0 and 1.
        public let integrity:Float
        public let seed:VariableLongJava
        /// 0x01: Ignore entities; 0x02: Show air; 0x04: Show bounding box.
        public let flags:Int8
        
        public enum Action : Int, Codable, PacketEncodableMojangJava {
            case update_data
            case save
            case load
            case detect_size
        }
        public enum Mode : Int, Codable, PacketEncodableMojangJava {
            case save
            case load
            case corner
            case data
        }
        
        public enum Mirror : Int, Codable, PacketEncodableMojangJava {
            case none
            case left_right
            case front_back
        }
        public enum Rotation : Int, Codable, PacketEncodableMojangJava {
            case none
            case clockwise_90
            case clockwise_180
            case counterclockwise_90
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                location,
                action,
                mode,
                name,
                offset_x,
                offset_y,
                offset_z,
                size_x,
                size_y,
                size_z,
                mirror,
                rotation,
                metadata,
                integrity,
                seed,
                flags
            ]
        }
    }
}
