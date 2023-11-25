//
//  EntityTeleportEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol EntityTeleportEvent : EntityEventCancellable {
    var new_location : any Location { get set }
    
    init(entity: any Entity, new_location: any Location)
}
