//
//  CPMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientPacketMojangProtocol {
        let entity_id:Int
        let animation_id:Int
    }
}
