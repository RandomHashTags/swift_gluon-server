//
//  CPMPSetTitleText.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetTitleText : ClientPacketMojangPlayProtocol {
        public let text:ChatPacketMojang
    }
}
