//
//  CPMPSetHealth.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server to set the health of the player it is sent to.
    ///
    /// Food saturation acts as a food “overcharge”. Food values will not decrease while the saturation is over zero. New players logging in or respawning automatically get a saturation of 5.0. Eating food increases the saturation as well as the food bar.
    struct SetHealth : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.set_health
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let health:Float = try packet.read_float()
            let food:VariableInteger = try packet.read_var_int()
            let food_saturation:Float = try packet.read_float()
            return Self(health: health, food: food, food_saturation: food_saturation)
        }
        /// 0 or less = dead, 20 = full HP.
        public let health:Float
        /// 0–20.
        public let food:VariableInteger
        /// Seems to vary from 0.0 to 5.0 in integer increments.
        public let food_saturation:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [health, food, food_saturation]
        }
    }
}
