//
//  MinecraftClientHandler.swift
//
//
//  Created by Evan Anderson on 11/25/23.
//

import Foundation

public protocol MinecraftClientHandler : AnyObject, Hashable {
    
    associatedtype ProtocolVersion : MinecraftProtocolVersionProtocol
    associatedtype PlayerType : Player
    
    static var platform : PacketPlatform { get }
    
    var protocol_version : ProtocolVersion { get }
    var player : PlayerType? { get }
    
    func process_packet() throws
    
    func close()
    
    func send_packet_data(_ data: Data) throws
}
