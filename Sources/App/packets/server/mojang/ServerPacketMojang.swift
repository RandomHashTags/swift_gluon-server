//
//  ServerPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public enum ServerPacketMojang {
    
    public enum Handshaking {
    }
    public enum Status : UInt, Hashable, Codable {
        case status = 1
        case login  = 2
    }
}
