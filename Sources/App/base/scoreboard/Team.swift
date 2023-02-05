//
//  Team.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Team : Jsonable {
    public let name:String
    public var display_name:String
    public var prefix:String
    public var suffix:String
    
    public var allows_friendly_fire:Bool
    public var can_see_friendly_invisibles:Bool
}
