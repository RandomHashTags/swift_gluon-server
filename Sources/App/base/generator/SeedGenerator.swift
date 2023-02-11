//
//  SeedGenerator.swift
//  
//
//  Created by Evan Anderson on 2/10/23.
//

import Foundation

internal enum SeedGenerator {
    static func get_random() -> Int64 {
        return Int64.random(in: Int64.min...Int64.max)
    }
}
