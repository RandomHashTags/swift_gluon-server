//
//  RecipeResult.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol RecipeResult : Identifiable where ID == String {
    var material : (any Material)? { get }
    var item_stack : (any ItemStack)? { get }
}
