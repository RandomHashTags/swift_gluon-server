//
//  RecipeChoice.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public struct RecipeChoice : Jsonable {
    /// - Returns: All allowed material identifiers that can be used as an ingredient, for a given slot.
    public let material_identifiers:Set<String>
}
public extension RecipeChoice {
    var materials : [Material]? {
        return GluonServer.get_materials(identifiers: material_identifiers)
    }
}
