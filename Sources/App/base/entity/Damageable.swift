//
//  Damageable.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Damageable : Entity {
    var health:Float { get set }
    var health_maximum:Float { get set }
    
    func tick_damageable()
    
    func damage(amount: Float)
}
