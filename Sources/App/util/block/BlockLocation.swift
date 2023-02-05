//
//  BlockLocation.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct BlockLocation : Hashable {
    public let world:UnsafePointer<World>
    public var x:Int64
    public var y:Int64
    public var z:Int64
}
