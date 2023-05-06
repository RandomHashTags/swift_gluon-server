//
//  EntityDamageEvent.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EntityDamageEvent : EntityEventCancellable {
    var cause : DamageCause { get }
    var amount : Double { get set }
    var will_die : Bool { get }
    
    init(entity: any Entity, cause: DamageCause, amount: Double)
}
