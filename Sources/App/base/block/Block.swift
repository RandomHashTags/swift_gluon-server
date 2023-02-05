//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct Block : Hashable {
    public var type : Material {
        didSet {
            
        }
    }
    public var light_level:UInt8
    public var location:Location
}
