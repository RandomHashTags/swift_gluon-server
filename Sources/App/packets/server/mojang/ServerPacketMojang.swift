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
    public enum Login {
    }
    public enum Play {
    }
    public enum Status : Int, Hashable, Codable, PacketEncodableMojang {
        case status = 1
        case login  = 2
    }
}
