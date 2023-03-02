//
//  SeedGenerator.swift
//  
//
//  Created by Evan Anderson on 2/10/23.
//

import Foundation

internal enum SeedGenerator {
    /// Returns a random number between `Int64.min` and `Int64.max`.
    static func get_random() -> Int64 {
        return Int64.random(in: Int64.min...Int64.max)
    }
}
