//
//  CPMLDisconnect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    struct Disconnect : ClientPacketMojangProtocol {
        /// The reason why the player was disconnected.
        let reason:ChatPacketMojang
    }
}
