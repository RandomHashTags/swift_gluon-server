//
//  GluonRecipe.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonRecipe : Recipe {
    typealias TargetItemStack = GluonItemStack
    
    var ingredients:[UInt:Set<String>]
    var result:TargetItemStack
}
