//
//  Recipe.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public struct Recipe : Jsonable {
    public let ingredients:[Int:RecipeChoice]
    public let result:ItemStack
}
