//
//  DifficultyJava.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public struct DifficultyJava : CaseIterable, Difficulty {
    public static var allCases: [DifficultyJava] = [
        DifficultyJava.peaceful,
        DifficultyJava.easy,
        DifficultyJava.normal,
        DifficultyJava.hard,
    ]
    
    public static var peaceful : DifficultyJava = {
        return DifficultyJava(id: "minecraft.peaceful", name: "Peaceful", damage_multiplier: 0.0)
    }()
    
    public static var easy : DifficultyJava = {
        return DifficultyJava(id: "minecraft.easy", name: "Easy", damage_multiplier: 0.5)
    }()
    
    public static var normal : DifficultyJava = {
        return DifficultyJava(id: "minecraft.normal", name: "Normal", damage_multiplier: 1)
    }()
    
    public static var hard : DifficultyJava = {
        return DifficultyJava(id: "minecraft.hard", name: "Hard", damage_multiplier: 1.5)
    }()
    
    public let id:String
    public let name:String
    public let damage_multiplier:Double
}
