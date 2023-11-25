//
//  ServerPacketMojangJavaStatus.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacket.Mojang.Java {
    enum Status : UInt8, PacketGameplayID {
        case status_request = 0
        case ping_request   = 1
        
        public var packet : any ServerPacketMojangJavaStatusProtocol.Type {
            switch self {
            case .status_request: return ServerPacket.Mojang.Java.Status.StatusRequest.self
            case .ping_request:   return ServerPacket.Mojang.Java.Status.PingRequest.self
            }
        }
    }
}
