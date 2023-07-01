//
//  ExplosionEffect.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol ExplosionEffect : Hashable, Identifiable where ID == UUID {
}

public extension ExplosionEffect {
    static func == (left: any ExplosionEffect, right: any ExplosionEffect) -> Bool {
        return left.id == right.id
    }
    static func == (left: Self, right: Self) -> Bool {
        return left.id == right.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
