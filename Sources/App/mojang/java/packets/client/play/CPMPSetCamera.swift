//
//  CPMPSetCamera.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Sets the entity that the player renders from. This is normally used when the player left-clicks an entity while in spectator mode.
    ///
    /// The player's camera will move with the entity and look where it is looking. The entity is often another player, but can be any type of entity. The player is unable to move this entity (move packets will act as if they are coming from the other entity).
    ///
    /// If the given entity is not loaded by the player, this packet is ignored. To return control to the player, send this packet with their entity ID.
    ///
    /// The Notchian server resets this (sends it back to the default entity) whenever the spectated entity is killed or the player sneaks, but only if they were spectating an entity. It also sends this packet whenever the player switches out of spectator mode (even if they weren't spectating an entity).
    ///
    /// The notchian client also loads certain shaders for given entities:
    /// - Creeper → `shaders/post/creeper.json`
    /// - Spider (and cave spider) → `shaders/post/spider.json`
    /// - Enderman → `shaders/post/invert.json`
    /// - Anything else → the current shader is unloaded
    struct SetCamera : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_camera
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let camera_id:VariableIntegerJava = try packet.read_var_int()
            return Self(camera_id: camera_id)
        }
        
        /// ID of the entity to set the client's camera to.
        public let camera_id:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [camera_id]
        }
    }
}
