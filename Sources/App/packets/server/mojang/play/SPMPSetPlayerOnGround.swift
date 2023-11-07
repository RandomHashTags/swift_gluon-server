//
//  SPMPSetPlayerOnGround.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// This packet as well as [Set Player Position](https://wiki.vg/Protocol#Set_Player_Position ), [Set Player Rotation](https://wiki.vg/Protocol#Set_Player_Rotation ), and [Set Player Position and Rotation](https://wiki.vg/Protocol#Set_Player_Position_and_Rotation) are called the “serverbound movement packets”. Vanilla clients will send Move Player Position once every 20 ticks even for a stationary player.
    ///
    /// This packet is used to indicate whether the player is on ground (walking/swimming), or airborne (jumping/falling).
    ///
    /// When dropping from sufficient height, fall damage is applied when this state goes from false to true. The amount of damage applied is based on the point where it last changed from true to false. Note that there are several movement related packets containing this state.
    struct SetPlayerOnGround : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.set_player_on_ground
        
        /// True if the client is on the ground, false otherwise.
        public let on_ground:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [on_ground]
        }
    }
}
