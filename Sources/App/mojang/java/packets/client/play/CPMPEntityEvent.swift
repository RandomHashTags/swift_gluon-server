//
//  CPMPEntityEvent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Entity statuses generally trigger an animation for an entity. The available statuses vary by the entity's type (and are available to subclasses of that type as well).
    struct EntityEvent : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.entity_event
        
        public let entityID:Int
        public let entityStatus:Int // TODO: support (https://wiki.vg/Entity_statuses)
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, entityStatus]
        }
    }
}
