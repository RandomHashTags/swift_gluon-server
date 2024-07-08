//
//  CPMPUpdateRecipes.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct UpdateRecipes : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_recipes
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let count:VariableIntegerJava = try packet.readVarInt()
            let recipes:[UpdateRecipes.UpdateRecipe] = try packet.read_map(count: count) {
                let identifier:Namespace = try packet.readIdentifier()
                let recipeID:Namespace = try packet.readIdentifier()
                let data:Data = Data() // TODO: fix
                return UpdateRecipes.UpdateRecipe(identifier: identifier, recipeID: recipeID, data: data)
            }
            return Self(count: count, recipes: recipes)
        }
        
        /// Number of elements in `recipes`.
        public let count:VariableIntegerJava
        public let recipes:[UpdateRecipes.UpdateRecipe]
        
        public struct UpdateRecipe : Codable, PacketEncodableMojangJava {
            public let identifier:Namespace
            public let recipeID:Namespace
            /// Additional data for the recipe.
            public let data:Data
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = try identifier.packet_bytes()
                array.append(contentsOf: try recipeID.packet_bytes())
                array.append(contentsOf: try data.packet_bytes())
                return array
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [count]
            array.append(contentsOf: recipes)
            return array
        }
    }
}
