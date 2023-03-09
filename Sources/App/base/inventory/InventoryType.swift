//
//  InventoryType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct InventoryType : Jsonable {
    public let identifier:String
    public let categories:[String]
    /// Maximum amount of slots this inventory type contains.
    public let size:UInt
    /// The allowed Recipes to be created in this inventory type.
    public let recipes:Set<Recipe>
}
