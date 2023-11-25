//
//  DefaultDifficulties.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public struct DefaultDifficulties : CaseIterable, Difficulty {
    public static var allCases: [DefaultDifficulties] = [
        DefaultDifficulties.peaceful,
        DefaultDifficulties.easy,
        DefaultDifficulties.normal,
        DefaultDifficulties.hard,
    ]
    
    public static var peaceful : DefaultDifficulties = {
        return DefaultDifficulties(id: "minecraft.peaceful", name: "Peaceful", damage_multiplier: 0.0)
    }()
    
    public static var easy : DefaultDifficulties = {
        return DefaultDifficulties(id: "minecraft.easy", name: "Easy", damage_multiplier: 0.5)
    }()
    
    public static var normal : DefaultDifficulties = {
        return DefaultDifficulties(id: "minecraft.normal", name: "Normal", damage_multiplier: 1)
    }()
    
    public static var hard : DefaultDifficulties = {
        return DefaultDifficulties(id: "minecraft.hard", name: "Hard", damage_multiplier: 1.5)
    }()
    
    public let id:String
    public let name:String
    public let damage_multiplier:Double
}
