//
//  Scoreboard.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Scoreboard {
    var objectives : [any Objective] { get set }
    var teams : [any Team] { get set }
}
