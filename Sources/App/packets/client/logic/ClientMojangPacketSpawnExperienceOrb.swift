//
//  ClientMojangPacketSpawnExperienceOrb.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

struct ClientMojangPacketSpawnExperienceOrb : ClientMojangPacket {
    let entity_id:Int
    let x:Double
    let y:Double
    let z:Double
    /// The amount of experience this orb will reward once collected.
    let count:Int
}
