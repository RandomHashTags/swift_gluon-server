//
//  SPMPPlaceRecipe.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// This packet is sent when a player clicks a recipe in the crafting book that is craftable (white border).
    struct PlaceRecipe : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.place_recipe
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let windowID:Int8 = try packet.readByte()
            let recipe:Namespace = try packet.readIdentifier()
            let make_all:Bool = try packet.readBool()
            return Self(windowID: windowID, recipe: recipe, make_all: make_all)
        }
        
        public let windowID:Int8
        public let recipe:Namespace
        /// Affects the amount of items processed; true if shift is down when clicked.
        public let make_all:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID, recipe, make_all]
        }
    }
}
