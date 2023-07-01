//
//  Difficulty.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Difficulty : MultilingualName, Identifiable where ID == String {
    var damage_multiplier : Double { get }
}
