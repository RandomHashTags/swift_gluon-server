//
//  SPMPInteract.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// This packet is sent from the client to the server when the client attacks or right-clicks another entity (a player, minecart, etc).
    ///
    /// A Notchian server only accepts this packet if the entity being attacked/used is visible without obstruction and within a 4-unit radius of the player's position.
    ///
    /// The target X, Y, and Z fields represent the difference between the vector location of the cursor at the time of the packet and the entity's position.
    ///
    /// Note that middle-click in creative mode is interpreted by the client and sent as a [Set Creative Mode Slot](https://wiki.vg/Protocol#Set_Creative_Mode_Slot) packet instead.
    struct Interact : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let type:Interact.InteractType = try packet.read_enum()
            let target_x:Float?
            let target_y:Float?
            let target_z:Float?
            let hand:Interact.Hand?
            switch type {
            case .interact:
                target_x = nil
                target_y = nil
                target_z = nil
                hand = try packet.read_enum()
                break
            case .attack:
                target_x = nil
                target_y = nil
                target_z = nil
                hand = nil
                break
            case .interact_at:
                target_x = try packet.read_float()
                target_y = try packet.read_float()
                target_z = try packet.read_float()
                hand = try packet.read_enum()
                break
            }
            let sneaking:Bool = try packet.read_bool()
            return Self(entity_id: entity_id, type: type, target_x: target_x, target_y: target_y, target_z: target_z, hand: hand, sneaking: sneaking)
        }
        
        /// The ID of the entity to interact.
        public let entity_id:VariableInteger
        public let type:Interact.InteractType
        /// Only if Type is interact at.
        public let target_x:Float?
        /// Only if Type is interact at.
        public let target_y:Float?
        /// Only if Type is interact at.
        public let target_z:Float?
        /// Only if Type is interact or interact at.
        public let hand:Interact.Hand?
        /// If the client is sneaking.
        public let sneaking:Bool
        
        public enum InteractType : Int, Hashable, Codable, PacketEncodableMojang {
            case interact
            case attack
            case interact_at
        }
        public enum Hand : Int, Hashable, Codable, PacketEncodableMojang {
            case main_hand
            case off_hand
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[any PacketEncodableMojang] = [entity_id, type]
            switch type {
            case .interact:
                let hand:Interact.Hand = try unwrap_optional(hand, key_path: \Self.hand, precondition: "type == .interact")
                array.append(hand)
                break
            case .attack:
                break
            case .interact_at:
                let precondition:String = "type == .interact_at"
                let x:Float = try unwrap_optional(target_x, key_path: \Self.target_x, precondition: precondition)
                let y:Float = try unwrap_optional(target_y, key_path: \Self.target_y, precondition: precondition)
                let z:Float = try unwrap_optional(target_z, key_path: \Self.target_z, precondition: precondition)
                let hand:Interact.Hand = try unwrap_optional(hand, key_path: \Self.hand, precondition: precondition)
                array.append(contentsOf: [x, y, z])
                array.append(hand)
                break
            }
            array.append(sneaking)
            return array
        }
    }
}
