//
//  SPMPPlaceRecipe.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// This packet is sent when a player clicks a recipe in the crafting book that is craftable (white border).
    struct PlaceRecipe : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.place_recipe
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:Int8 = try packet.read_byte()
            let recipe:Namespace = try packet.read_identifier()
            let make_all:Bool = try packet.read_bool()
            return Self(window_id: window_id, recipe: recipe, make_all: make_all)
        }
        
        public let window_id:Int8
        public let recipe:Namespace
        /// Affects the amount of items processed; true if shift is down when clicked.
        public let make_all:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [window_id, recipe, make_all]
        }
    }
}
