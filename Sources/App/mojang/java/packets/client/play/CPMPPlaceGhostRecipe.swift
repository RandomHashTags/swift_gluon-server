//
//  CPMPPlaceGhostRecipe.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Response to the serverbound packet ([Place Recipe](https://wiki.vg/Protocol#Place_Recipe) ), with the same recipe ID. Appears to be used to notify the UI.
    struct PlaceGhostRecipe : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.place_ghost_recipe
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:Int8 = try packet.read_byte()
            let recipe:Namespace = try packet.read_identifier()
            return Self(window_id: window_id, recipe: recipe)
        }
        
        public let window_id:Int8
        public let recipe:Namespace
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [window_id, recipe]
        }
    }
}
