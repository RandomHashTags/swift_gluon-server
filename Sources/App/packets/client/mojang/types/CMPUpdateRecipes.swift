//
//  CMPUpdateRecipes.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientMojangPacket {
    struct UpdateRecipes : ClientMojangPacketProtocol {
        /// Number of elements in `recipes`.
        let count:Int
        let recipes:[UpdateRecipes.UpdateRecipe]
        
        struct UpdateRecipe : Hashable, Codable {
            let identifiers:[String]
            let recipe_ids:[Int]
            /// Additional data for the recipe.
            let data:[String] // TODO: fix (make codable)
        }
    }
}
