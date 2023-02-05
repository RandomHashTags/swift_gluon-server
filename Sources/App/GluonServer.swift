//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

struct GluonServer {
    
    var enchantment_types:[EnchantmentType]
    var entities:[any Entity]
    
    func load() {
    }
    func pause() {
    }
    
    func tick() {
        for entity in entities {
            entity.tick()
        }
    }
}
