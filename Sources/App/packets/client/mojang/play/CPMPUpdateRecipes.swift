//
//  CPMPUpdateRecipes.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct UpdateRecipes : ClientPacketMojangPlayProtocol {
        /// Number of elements in `recipes`.
        public let count:Int
        public let recipes:[UpdateRecipes.UpdateRecipe]
        
        public struct UpdateRecipe : Hashable, Codable {
            public let identifiers:[String]
            public let recipe_ids:[Int]
            /// Additional data for the recipe.
            public let data:[Data]
        }
    }
}
