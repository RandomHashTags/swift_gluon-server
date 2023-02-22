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
    public let size:Int
    public let recipes:Set<Recipe>
}
