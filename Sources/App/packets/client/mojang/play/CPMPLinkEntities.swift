//
//  CPMPLinkEntities.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is sent when an entity has been leashed to another entity.
    struct LinkEntities : ClientPacketMojangPlayProtocol {
        /// Attached entity's EID.
        public let attached_entity_id:Int
        /// ID of the entity holding the lead. Set to -1 to detach.
        public let holding_entity_id:Int
    }
}
