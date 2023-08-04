//
//  ClientPacketMojangStatus.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public enum ClientPacketMojangStatus : UInt, PacketGameplayID {
    case status_response = 0
    case ping_response   = 1
    
    public var packet : any ClientPacketMojangStatusProtocol.Type {
        switch self {
        case .status_response: return ClientPacketMojang.Status.StatusResponse.self
        case .ping_response:   return ClientPacketMojang.Status.PingResponse.self
        }
    }
}
