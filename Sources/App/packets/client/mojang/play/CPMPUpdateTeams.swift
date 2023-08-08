//
//  CPMPUpdateTeams.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Creates and updates teams.
    struct UpdateTeams : ClientPacketMojangPlayProtocol {
        /// A unique name for the team. (Shared with scoreboard).
        public let team_name:String
        /// Determines the layout of the remaining packet.
        public let mode:UpdateTeams.Mode
        
        // Remove Team has no fields
        
        // Create Team, Update Team Info
        public let team_display_name:ChatPacketMojang?
        /// Bit mask. 0x01: Allow friendly fire, 0x02: can see invisible players on same team.
        public let friendly_flags:Int8?
        public let name_tag_visibility:UpdateTeams.NameTagVisibility?
        public let collision_rule:UpdateTeams.CollisionRule?
        /// Used to color the name of players on the team.
        public let team_color:VariableInteger? // TODO: add `TeamColor enum`
        /// Displayed before the names of players that are part of this team.
        public let team_prefix:ChatPacketMojang?
        /// Displayed after the names of players that are part of this team.
        public let team_suffix:ChatPacketMojang?
        
        // + create_team || add_entities_to_team || remove_entities_from_team
        /// Number of elements in `entities`.
        public let entity_count:VariableInteger?
        // + create_team || add_entities_to_team || remove_entities_from_team
        /// Identifiers for the entities in this team. For players, this is their username; for other entities, it is their UUID.
        public let entities:[String]?
        
        public enum Mode : Int, Hashable, Codable, PacketEncodableMojang {
            case create_team =               0
            case remove_team =               1
            case update_team_info =          2
            case add_entities_to_team =      3
            case remove_entities_from_team = 4
        }
        
        public enum NameTagVisibility : String, Hashable, Codable, PacketEncodableMojang {
            case always
            case hideForOtherTeams
            case hideForOwnTeam
            case never
        }
        
        public enum CollisionRule : String, Hashable, Codable, PacketEncodableMojang {
            case always
            case pushOtherTeams
            case pushOwnTeam
            case never
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [
                team_name,
                mode
            ]
            var secondary:[(any PacketEncodableMojang)?]
            switch mode {
            case .create_team, .update_team_info:
                let precondition:String = "mode == .\(mode)"
                let team_display_name:ChatPacketMojang = try unwrap_optional(team_display_name, key_path: \UpdateTeams.team_display_name, precondition: precondition)
                let friendly_flags:Int8 = try unwrap_optional(friendly_flags, key_path: \UpdateTeams.friendly_flags, precondition: precondition)
                let name_tag_visibility:UpdateTeams.NameTagVisibility = try unwrap_optional(name_tag_visibility, key_path: \UpdateTeams.name_tag_visibility, precondition: precondition)
                let collision_rule:UpdateTeams.CollisionRule = try unwrap_optional(collision_rule, key_path: \UpdateTeams.collision_rule, precondition: precondition)
                let team_color:VariableInteger = try unwrap_optional(team_color, key_path: \UpdateTeams.team_color, precondition: precondition)
                let team_prefix:ChatPacketMojang = try unwrap_optional(team_prefix, key_path: \UpdateTeams.team_prefix, precondition: precondition)
                let team_suffix:ChatPacketMojang = try unwrap_optional(team_suffix, key_path: \UpdateTeams.team_suffix, precondition: precondition)
                secondary = [
                    team_display_name,
                    friendly_flags,
                    name_tag_visibility,
                    collision_rule,
                    team_color,
                    team_prefix,
                    team_suffix
                ]
                if mode == .create_team {
                    let entity_count:VariableInteger = try unwrap_optional(entity_count, key_path: \UpdateTeams.entity_count, precondition: precondition)
                    let entities:[String] = try unwrap_optional(entities, key_path: \UpdateTeams.entities, precondition: precondition)
                    secondary.append(entity_count)
                    secondary.append(contentsOf: entities)
                }
                break
            case .remove_team:
                secondary = []
                break
            case .add_entities_to_team, .remove_entities_from_team:
                let precondition:String = "mode == .\(mode)"
                let entity_count:VariableInteger = try unwrap_optional(entity_count, key_path: \UpdateTeams.entity_count, precondition: precondition)
                let entities:[String] = try unwrap_optional(entities, key_path: \UpdateTeams.entities, precondition: precondition)
                secondary = [entity_count]
                secondary.append(contentsOf: entities)
                break
            }
            array.append(contentsOf: secondary)
            
            return array
        }
    }
}
