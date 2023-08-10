//
//  SPMPUseItemOn.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// !
    ///
    /// Upon placing a block, this packet is sent once.
    ///
    /// The Cursor Position X/Y/Z fields (also known as in-block coordinates) are calculated using raytracing. The unit corresponds to sixteen pixels in the default resource pack. For example, let's say a slab is being placed against the south face of a full block. The Cursor Position X will be higher if the player was pointing near the right (east) edge of the face, lower if pointing near the left. The Cursor Position Y will be used to determine whether it will appear as a bottom slab (values 0.0–0.5) or as a top slab (values 0.5-1.0). The Cursor Position Z should be 1.0 since the player was looking at the southernmost part of the block.
    ///
    /// Inside block is true when a player's head (specifically eyes) are inside of a block's collision. In 1.13 and later versions, collision is rather complicated and individual blocks can have multiple collision boxes. For instance, a ring of vines has a non-colliding hole in the middle. This value is only true when the player is directly in the box. In practice, though, this value is only used by scaffolding to place in front of the player when sneaking inside of it (other blocks will place behind when you intersect with them -- try with glass for instance).
    struct UseItemOn : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let hand:UseItemOn.Hand = try packet.read_enum()
            let location:PositionPacketMojang = try packet.read_packet_decodable()
            let face:PlayerAction.Face = try packet.read_enum()
            let cursor_position_x:Float = try packet.read_float()
            let cursor_position_y:Float = try packet.read_float()
            let cursor_position_z:Float = try packet.read_float()
            let inside_block:Bool = try packet.read_bool()
            let sequence:VariableInteger = try packet.read_var_int()
            return Self(hand: hand, location: location, face: face, cursor_position_x: cursor_position_x, cursor_position_y: cursor_position_y, cursor_position_z: cursor_position_z, inside_block: inside_block, sequence: sequence)
        }
        
        public let hand:UseItemOn.Hand
        /// Block position.
        public let location:PositionPacketMojang
        /// The face on which the block is placed (as documented at [Player Action](https://wiki.vg/Protocol#Player_Action )).
        public let face:PlayerAction.Face
        /// The position of the crosshair on the block, from 0 to 1 increasing from west to east.
        public let cursor_position_x:Float
        /// The position of the crosshair on the block, from 0 to 1 increasing from bottom to top.
        public let cursor_position_y:Float
        /// The position of the crosshair on the block, from 0 to 1 increasing from north to south.
        public let cursor_position_z:Float
        /// True when the player's head is inside of a block.
        public let inside_block:Bool
        public let sequence:VariableInteger
        
        public enum Hand : Int, Hashable, Codable, PacketEncodableMojang {
            case main_hand
            case off_hand
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [
                hand,
                location,
                face,
                cursor_position_x,
                cursor_position_y,
                cursor_position_z,
                inside_block,
                sequence
            ]
        }
    }
}
