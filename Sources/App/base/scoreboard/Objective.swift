//
//  Objective.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Objective {
    var name : String { get }
    var display_name : String { get }
    var criteria : String { get }
}
