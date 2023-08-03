//
//  CPMPClearTitles.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Clear the client's current title information, with the option to also reset it.
    struct ClearTitles : ClientPacketMojangProtocol {
        let reset:Bool
    }
}
