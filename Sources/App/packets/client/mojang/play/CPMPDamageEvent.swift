//
//  CPMPDamageEvent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct DamageEvent : ClientPacketMojangProtocol {
        /// The ID of the entity taking damage.
        let entity_id:Int
        /// The ID of the type of damage taken.
        let source_type_id:Int
        /// The ID + 1 of the entity responsible for the damage, if present. If not present, the value is 0.
        let source_cause_id:Int
        /// The ID + 1 of the entity that directly dealt the damage, if present. If not present, the value is 0.
        ///
        /// If this field is present:
        /// - and damage was dealt indirectly, such as by the use of a projectile, this field will contain the ID of such projectile;
        /// - and damage was dealt dirctly, such as by manually attacking, this field will contain the same value as Source Cause ID
        let source_direct_id:Int
        /// Indicates the presence of `source_position_x`, `source_position_y` and `source_position_z`.
        ///
        /// The Notchian server sends the Source Position when the damage was dealt by the /damage command and a position was specified
        let has_source_position:Bool
        /// Only present if `has_source_position` is `true`.
        let source_position_x:Double?
        /// Only present if `has_source_position` is `true`.
        let source_position_y:Double?
        /// Only present if `has_source_position` is `true`.
        let source_position_z:Double?
    }
}
