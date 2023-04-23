//
//  Projectile.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol Projectile : Entity {
    var source : ProjectileSource? { get }
}
