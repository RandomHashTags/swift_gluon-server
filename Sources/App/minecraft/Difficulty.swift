//
//  Difficulty.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs

public struct Difficulty : Identifiable, MultilingualName {
    public let id:String
    public let name:LocalizedStringResource
    public let damage_multiplier:Double
}

public extension Difficulty {
    static let peaceful:Difficulty = Difficulty(id: "minecraft.peaceful", name: "Peaceful", damage_multiplier: 0.0)
    static let easy:Difficulty = Difficulty(id: "minecraft.easy", name: "Easy", damage_multiplier: 0.5)
    static let normal:Difficulty =  Difficulty(id: "minecraft.normal", name: "Normal", damage_multiplier: 1)
    static let hard:Difficulty = Difficulty(id: "minecraft.hard", name: "Hard", damage_multiplier: 1.5)
}