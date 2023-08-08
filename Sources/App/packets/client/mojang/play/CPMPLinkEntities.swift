//
//  CPMPLinkEntities.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is sent when an entity has been [leashed](https://minecraft.fandom.com/wiki/Lead) to another entity.
    struct LinkEntities : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let attached_entity_id:Int32 = try packet.read_int()
            let holding_entity_id:Int32 = try packet.read_int()
            return Self(attached_entity_id: attached_entity_id, holding_entity_id: holding_entity_id)
        }
        
        /// Attached entity's EID.
        public let attached_entity_id:Int32
        /// ID of the entity holding the lead. Set to -1 to detach.
        public let holding_entity_id:Int32
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [attached_entity_id, holding_entity_id]
        }
    }
}
