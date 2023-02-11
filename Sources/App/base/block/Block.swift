//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct Block : Hashable {
    public var material_identifier:String
    public var material : Material? {
        return GluonServer.get_material(identifier: material_identifier)
    }
    public var light_level:UInt8
    public var location:Location
    
    public func break_naturally() {
    }
}
