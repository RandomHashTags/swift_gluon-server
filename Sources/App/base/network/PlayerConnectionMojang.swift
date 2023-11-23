//
//  PlayerConnectionMojang.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation
import Socket

public final class PlayerConnectionMojang : PlayerConnection {
    public let platform:PacketPlatform
    public let protocol_version:MinecraftProtocolVersion
    public var socket:Socket
    private var connection_task:Task<Void, Never>!
    public internal(set) var ping:UInt16
    
    public internal(set) var information:ServerPacketMojang.Configuration.ClientInformation!
    
    init(platform: PacketPlatform, protocol_version: MinecraftProtocolVersion, socket: Socket) {
        self.platform = platform
        self.protocol_version = protocol_version
        self.socket = socket
        ping = 0
        
        connection_task = Task {
            while socket.isActive {
                process_packet()
            }
        }
    }
    
    func process_packet() {
        do {
            let packet:GeneralPacketMojang = try read_packet()
        } catch {
            print("ServerMojangClient;process_packet;error=\(error)")
        }
    }
    
    func read_packet() throws -> GeneralPacketMojang {
        var data:Data = Data()
        let _:Int = try socket.read(into: &data)
        let bytes:[UInt8] = [UInt8](data)
        return try GeneralPacketMojang(bytes: bytes)
    }
    
    public func close(reason: String) {
        connection_task.cancel()
        socket.close()
    }
    
    public func send_packet<T : Packet>(_ packet: T) throws {
        guard let packet:any PacketMojang = packet as? any PacketMojang else { return }
        try socket.send_packet(packet)
    }
}
