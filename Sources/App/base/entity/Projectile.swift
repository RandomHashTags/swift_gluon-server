//
//  Projectile.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol Projectile : Entity {
    var source : ProjectileSource? { get }
    func tick_projectile(_ server: any Server)
}
public extension Projectile {
    func tick(_ server: any Server) {
        tick_projectile(server)
    }
    func tick_projectile(_ server: any Server) {
        default_tick_projectile(server)
    }
    func default_tick_projectile(_ server: any Server) {
        tick_entity(server)
    }
}
