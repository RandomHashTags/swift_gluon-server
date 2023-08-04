//
//  CPMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientPacketMojangPlayProtocol {
        public let entity_id:Int
        public let animation_id:Int
    }
}
