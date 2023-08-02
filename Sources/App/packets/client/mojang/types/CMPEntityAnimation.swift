//
//  CMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientMojangPacket {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientMojangPacketProtocol {
        let entity_id:Int
        let animation_id:Int
    }
}
