//
//  WorldBorder.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct WorldBorder : Jsonable {
    public var size:Double
    public var center:Vector
    
    public var warning_distance:UInt
}
