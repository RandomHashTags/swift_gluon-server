//
//  ClientMojangPacketEntityAnimation.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

/// Sent whenever an entity should change animation.
struct ClientMojangPacketEntityAnimation : ClientMojangPacket {
    let entity_id:Int
    let animation_id:Int
}
