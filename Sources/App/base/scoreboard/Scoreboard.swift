//
//  Scoreboard.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Scoreboard : Jsonable {
    public let objectives:Set<Objective>
    public let teams:Set<Team>
}
