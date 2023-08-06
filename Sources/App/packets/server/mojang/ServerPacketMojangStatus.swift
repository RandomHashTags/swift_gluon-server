//
//  ServerPacketMojangStatus.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public enum ServerPacketMojangStatus : UInt8, PacketGameplayID {
    case status_request = 0
    case ping_request   = 1
    
    public var packet : any ServerPacketMojangStatusProtocol.Type {
        switch self {
        case .status_request: return ServerPacketMojang.Status.StatusRequest.self
        case .ping_request:   return ServerPacketMojang.Status.PingRequest.self
        }
    }
}
