//
//  CPMPOpenHorseScreen.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is used exclusively for opening the horse GUI. Open Screen is used for all other GUIs. The client will not open the inventory if the Entity ID does not point to an horse-like animal.
    struct OpenHorseScreen : ClientPacketMojangProtocol {
        let window_id:UInt
        let slot_count:Int
        let entity_id:Int
    }
}
