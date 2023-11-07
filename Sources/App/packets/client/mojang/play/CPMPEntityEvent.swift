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
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.entity_event
        
        public let entity_id:Int
        public let entity_status:Int // TODO: support (https://wiki.vg/Entity_statuses)
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [entity_id, entity_status]
        }
    }
}
