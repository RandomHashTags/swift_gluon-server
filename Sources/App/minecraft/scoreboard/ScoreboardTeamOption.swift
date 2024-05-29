//
//  ScoreboardTeamOption.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

public enum ScoreboardTeamOption : String {
    case name_tag_visibility
    case death_message_visibility
    case collision_rule

    public enum Status : String {
        case always
        case never
        case for_other_teams
        case for_own_team
    }
}