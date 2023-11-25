//
//  CPMPUpdateRecipes.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    struct UpdateRecipes : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_recipes
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let count:VariableInteger = try packet.read_var_int()
            let recipes:[UpdateRecipes.UpdateRecipe] = try packet.read_map(count: count) {
                let identifier:Namespace = try packet.read_identifier()
                let recipe_id:Namespace = try packet.read_identifier()
                let data:Data = Data() // TODO: fix
                return UpdateRecipes.UpdateRecipe(identifier: identifier, recipe_id: recipe_id, data: data)
            }
            return Self(count: count, recipes: recipes)
        }
        
        /// Number of elements in `recipes`.
        public let count:VariableInteger
        public let recipes:[UpdateRecipes.UpdateRecipe]
        
        public struct UpdateRecipe : Hashable, Codable, PacketEncodableMojang {
            public let identifier:Namespace
            public let recipe_id:Namespace
            /// Additional data for the recipe.
            public let data:Data
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = try identifier.packet_bytes()
                array.append(contentsOf: try recipe_id.packet_bytes())
                array.append(contentsOf: try data.packet_bytes())
                return array
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [count]
            array.append(contentsOf: recipes)
            return array
        }
    }
}
