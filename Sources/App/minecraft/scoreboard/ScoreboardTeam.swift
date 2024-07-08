//
//  ScoreboardTeam.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct ScoreboardTeam {
    public var name:String
    public var displayName:String
    public var prefix:String
    public var suffix:String
    
    public var allowsFriendlyFire:Bool
    public var canSeeFriendlyInvisibles:Bool
    
    public var options:[ScoreboardTeamOption:ScoreboardTeamOption.Status]
}
