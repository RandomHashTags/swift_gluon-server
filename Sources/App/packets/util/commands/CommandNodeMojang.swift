//
//  CommandNodeMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public struct CommandNodeMojang : Hashable, Codable, PacketEncodableMojang, PacketDecodableMojang {
    public static func decode(from packet: GeneralPacketMojang) throws -> Self {
        let flags:Int8 = try packet.read_byte()
        let children_count:VariableInteger = try packet.read_var_int()
        let children:[VariableInteger] = try packet.read_map(count: children_count) {
            return try packet.read_var_int()
        }
        let redirect_node:VariableInteger?
        if (flags & 0x08) != 0 {
            redirect_node = try packet.read_var_int()
        } else {
            redirect_node = nil
        }
        
        let flag_node_type:Int8 = flags & 0x03
        
        let name:String?
        let parser:CommandNodeMojang.Parser?
        let properties:Data?
        switch flag_node_type {
        case 1:
            name = try packet.read_string()
            parser = nil
            properties = nil
            break
        case 2:
            name = try packet.read_string()
            parser = try packet.read_enum()
            properties = nil // TODO: fix
            break
        default:
            name = nil
            parser = nil
            properties = nil
            break
        }
        
        let suggestions_type:Namespace?
        if (flags & 0x10) != 0 {
            suggestions_type = try packet.read_identifier()
        } else {
            suggestions_type = nil
        }
        return Self(flags: flags, children_count: children_count, children: children, redirect_node: redirect_node, name: name, parser: parser, properties: properties, suggestions_type: suggestions_type)
    }
    
    let flags:Int8
    let children_count:VariableInteger
    let children:[VariableInteger]
    let redirect_node:VariableInteger?
    let name:String?
    let parser:CommandNodeMojang.Parser?
    let properties:Data?
    let suggestions_type:Namespace?
    
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = try flags.packet_bytes()
        array.append(contentsOf: try children_count.packet_bytes())
        for child in children {
            array.append(contentsOf: try child.packet_bytes())
        }
        if (flags & 0x08) != 0 {
            let redirect_node:VariableInteger = try unwrap_optional(redirect_node, key_path: \Self.redirect_node, precondition: "(flags & 0x08) != 0")
            array.append(contentsOf: try redirect_node.packet_bytes())
        }
        return array
    }
    
    public enum Parser : Int, Hashable, Codable, PacketEncodableMojang {
        case brigadier_bool = 0
        case brigadier_float = 1
        case brigadier_double
        case brigadier_integer
        case brigadier_long
        case brigadier_string
        case minecraft_entity
        case minecraft_game_profile
        case minecraft_block_pos
        case minecraft_column_pos
        case minecraft_vec3
        case minecraft_vec2
        case minecraft_block_state
        case minecraft_block_predicate
        case minecraft_item_stack
        case minecraft_item_predicate
        case minecraft_color
        case minecraft_component
        case minecraft_message
        case minecraft_nbt
        case minecraft_nbt_tag
        case minecraft_nbt_path
        case minecraft_objective
        case minecraft_objective_criteria
        case minecraft_operation
        case minecraft_particle
        case minecraft_angle
        case minecraft_rotation
        case minecraft_scoreboard_slot
        case minecraft_score_holder
        case minecraft_swizzle
        case minecraft_team
        case minecraft_item_slot
        case minecraft_resource_location
        case minecraft_function
        case minecraft_entity_anchor
        case minecraft_int_range
        case minecraft_float_range
        case minecraft_dimension
        case minecraft_gamemode
        case minecraft_time
        case minecraft_resource_or_tag
        case minecraft_resource_or_tag_key
        case minecraft_resource
        case minecraft_resource_key
        case minecraft_template_mirror
        case minecraft_template_rotation
        case minecraft_heightmap
        case minecraft_uuid
    }
    public enum Properties {
        public enum Brigadier {
            public struct Double : CommandNodeMojangProperty {
                public let flags:UInt8
                public let min:Swift.Double?
                public let max:Swift.Double?
                
                public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
                    var array:[(any PacketEncodableMojang)?] = [flags]
                    if (flags & 0x01) != 0 {
                        array.append(min)
                    }
                    if (flags & 0x02) != 0 {
                        array.append(max)
                    }
                    return array
                }
            }
        }
    }
}

public protocol CommandNodeMojangProperty : Hashable, Codable, PacketEncodableMojang {
    func encoded_values() throws -> [(any PacketEncodableMojang)?]
}
public extension CommandNodeMojangProperty {
    func packet_bytes() throws -> [UInt8] {
        return try encoded_values().compactMap({ $0 }).map({ try $0.packet_bytes() }).flatMap({ $0 })
    }
}
