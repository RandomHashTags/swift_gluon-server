//
//  CPMPSpawnPlayer.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is sent by the server when a player comes into visible range, not when a player joins.
    ///
    /// This packet must be sent after the Player Info Update packet that adds the player data for the client to use when spawning a player. If the Player Info for the player spawned by this packet is not present when this packet arrives, Notchian clients will not spawn the player entity. The Player Info packet includes skin/cape data.
    ///
    /// Servers can, however, safely spawn player entities for players not in visible range. The client appears to handle it correctly.
    struct SpawnPlayer : ClientPacketMojangProtocol {
        /// A unique integer ID mostly used to identify the player.
        let entity_id:Int
        let player_uuid:UUID
        let x:Double
        let y:Double
        let z:Double
        let yaw:Float
        let pitch:Float
    }
}
