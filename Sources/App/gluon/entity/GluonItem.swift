//
//  GluonItem.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonItem : Item {
    public typealias TargetLocation = GluonLocation
    public typealias TargetItemStack = GluonItemStack
    
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
    public var passengers : [any Entity] {
        return GluonServer.shared_instance.get_entities(uuids: passenger_uuids)
    }
    public var vehicle_uuid:UUID?
    public var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    public var item_stack:TargetItemStack
    public var pickup_delay:UInt8
    
    public mutating func tick(_ server: any Server) {
        tick_item(server)
    }
    public func save() {
    }
}
