//
//  CPMPPlaceGhostRecipe.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Response to the serverbound packet ([Place Recipe](https://wiki.vg/Protocol#Place_Recipe) ), with the same recipe ID. Appears to be used to notify the UI.
    struct PlaceGhostRecipe : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.place_ghost_recipe
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let windowID:Int8 = try packet.readByte()
            let recipe:Namespace = try packet.readIdentifier()
            return Self(windowID: windowID, recipe: recipe)
        }
        
        public let windowID:Int8
        public let recipe:Namespace
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID, recipe]
        }
    }
}
