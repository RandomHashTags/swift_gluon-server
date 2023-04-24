//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialConfiguration : Jsonable {
    associatedtype TargetMaterialItemConfiguration : MaterialItemConfiguration
    associatedtype TargetMaterialBlockConfiguration : MaterialBlockConfiguration
    
    var is_only_item : Bool { get }
    var is_only_block : Bool { get }
    var is_block_and_item : Bool { get }
    
    var item : TargetMaterialItemConfiguration? { get }
    var block : TargetMaterialBlockConfiguration? { get }
}
public extension MaterialConfiguration {
    var is_only_item : Bool { item != nil && block == nil }
    var is_only_block : Bool { item == nil && block != nil }
    var is_block_and_item : Bool { item != nil && block != nil }
}
