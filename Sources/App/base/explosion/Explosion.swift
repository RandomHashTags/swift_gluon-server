//
//  Explosion.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol Explosion : Hashable, Identifiable where ID == UUID {
    var location : any Location { get }
    var effect : any ExplosionEffect { get }
    
    var radius : Float { get }
}

public extension Explosion {
    static func == (left: any Explosion, right: any Explosion) -> Bool {
        return left.id == right.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location)
        hasher.combine(effect)
    }
}
