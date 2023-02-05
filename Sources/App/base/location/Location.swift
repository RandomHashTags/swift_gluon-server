//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Location : Jsonable {
    public var world:World
    public var x:Float
    public var y:Float
    public var z:Float
    public var yaw:Float
    public var pitch:Float
    
    public func is_similar(_ location: Location) -> Bool {
        return world == location.world && x == location.x && y == location.y && z == location.z
    }
}
