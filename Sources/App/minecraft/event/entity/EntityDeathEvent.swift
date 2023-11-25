//
//  EntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol EntityDeathEvent : EntityEvent {
    init(entity: any Entity)
}
