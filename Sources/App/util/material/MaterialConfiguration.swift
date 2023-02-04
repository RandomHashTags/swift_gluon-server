//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct MaterialConfiguration : Hashable {
    public var is_only_item:Bool { item != nil && block == nil }
    public var is_only_block:Bool { item == nil && block != nil }
    public var is_block_and_item:Bool { item != nil && block != nil }
    
    public let item:UnsafePointer<MaterialItemConfiguration>?
    public let block:UnsafePointer<MaterialBlockConfiguration>?
}
