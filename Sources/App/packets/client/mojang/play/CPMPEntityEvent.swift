//
//  CPMPEntityEvent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Entity statuses generally trigger an animation for an entity. The available statuses vary by the entity's type (and are available to subclasses of that type as well).
    struct EntityEvent : ClientPacketMojangPlayProtocol {
        public let entity_id:Int
        public let entity_status:Int // TODO: support (https://wiki.vg/Entity_statuses)
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [entity_id, entity_status]
        }
    }
}
