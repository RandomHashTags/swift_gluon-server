//
//  Material.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Material : Jsonable, Identifiable, MultilingualName {
    associatedtype TargetMaterialCategory : MaterialCategory
    associatedtype TargetMaterialConfiguration : MaterialConfiguration
    associatedtype TargetRecipe : Recipe
    
    var categories : [TargetMaterialCategory] { get }
    var configuration : TargetMaterialConfiguration { get }
    /// The ``Recipe`` identifier this material can be crafted by.
    var recipe_identifier : String? { get }
    var recipe : TargetRecipe? { get }
}
