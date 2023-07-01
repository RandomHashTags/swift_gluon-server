//
//  ScoreboardTeam.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol ScoreboardTeam {
    var name : String { get set }
    var display_name : String { get set }
    var prefix : String { get set }
    var suffix : String { get set }
    
    var allows_friendly_fire : Bool { get set }
    var can_see_friendly_invisibles : Bool { get set }
    
    var options : [ScoreboardTeamOption : ScoreboardTeamOptionStatus] { get set }
}
public enum ScoreboardTeamOption : String {
    case name_tag_visibility
    case death_message_visibility
    case collision_rule
}
public enum ScoreboardTeamOptionStatus : String {
    case always
    case never
    case for_other_teams
    case for_own_team
}
