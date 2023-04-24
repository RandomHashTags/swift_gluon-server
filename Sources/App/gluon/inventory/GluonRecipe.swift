//
//  GluonRecipe.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonRecipe : Recipe {
    public typealias TargetItemStack = GluonItemStack
    
    public var ingredients:[UInt:Set<String>]
    public var result:TargetItemStack
}
