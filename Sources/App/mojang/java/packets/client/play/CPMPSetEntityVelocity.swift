//
//  CPMPSetEntityVelocity.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Velocity is in units of 1/8000 of a block per server tick (50ms); for example, -1343 would move (-1343 / 8000) = −0.167875 blocks per tick (or −3.3575 blocks per second).
    struct SetEntityVelocity : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_entity_velocity
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableIntegerJava = try packet.read_var_int()
            let velocity_x:Int16 = try packet.read_short()
            let velocity_y:Int16 = try packet.read_short()
            let velocity_z:Int16 = try packet.read_short()
            return Self(entity_id: entity_id, velocity_x: velocity_x, velocity_y: velocity_y, velocity_z: velocity_z)
        }
        
        public let entity_id:VariableIntegerJava
        public let velocity_x:Int16
        public let velocity_y:Int16
        public let velocity_z:Int16
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                entity_id,
                velocity_x,
                velocity_y,
                velocity_z
            ]
        }
    }
}
