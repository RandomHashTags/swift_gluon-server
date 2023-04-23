//
//  GluonItem.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonItem : Item {
    public typealias TargetLocation = GluonLocation
    
    public var uuid:UUID
    public var type:EntityType
    public var ticks_lived:UInt64
    public var custom_name:String?
    public var display_name:String?
    
    public var boundaries:[Boundary]
    public var location:TargetLocation
    public var velocity:Vector
    public var fall_distance:Float
    public var is_glowing:Bool
    public var is_on_fire:Bool
    public var is_on_ground:Bool
    
    public var height:Float
    
    public var fire_ticks:UInt16
    public var fire_ticks_maximum:UInt16
    
    public var freeze_ticks:UInt16
    public var freeze_ticks_maximum:UInt16
    
    public var passenger_uuids:Set<UUID>
    public var vehicle_uuid:UUID?
    
    public var item_stack:ItemStack
    public var pickup_delay:UInt8
    
    public mutating func tick(_ server: any Server) {
        tick_item(server)
    }
    public func save() {
    }
}
