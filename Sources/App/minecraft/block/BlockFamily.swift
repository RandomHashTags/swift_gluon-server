//
//  BlockFamily.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

public protocol BlockFamily : Identifiable where ID == String {
    associatedtype BlockFamilyVariantType : BlockFamilyVariant
    associatedtype BlockType : Block
    
    var recipe_group_prefix : String? { get }
    var recipe_unlocked_by : String? { get }
    
    var variants : [BlockFamilyVariantType : BlockType] { get }
}
