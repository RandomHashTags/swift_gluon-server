//
//  ClientPacketMojangJavaStatus.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacket.Mojang.Java {
    enum Status : UInt8, PacketGameplayID {
        case status_response = 0
        case ping_response   = 1
        
        public var packet : any ClientPacketMojangJavaStatusProtocol.Type {
            switch self {
            case .status_response: return ClientPacket.Mojang.Java.Status.StatusResponse.self
            case .ping_response:   return ClientPacket.Mojang.Java.Status.PingResponse.self
            }
        }
    }
}
