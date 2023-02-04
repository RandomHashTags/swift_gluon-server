//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Entity : Hashable {
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.type == rhs.type
    }
    
    public let uuid:UInt64, type:UnsafePointer<EntityType>
    public var display_name:String?
    
    public var location:Location
    public var fall_distance:Float
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(type)
    }
    
    public init(uuid: UInt64, type: UnsafePointer<EntityType>, display_name: String? = nil, location: Location, fall_distance: Float) {
        self.uuid = uuid
        self.type = type
        self.display_name = display_name
        self.location = location
        self.fall_distance = fall_distance
    }
    
    public func tick() {
    }
}
