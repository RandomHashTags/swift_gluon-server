//
//  PlayerConnectionMojang.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class PlayerConnectionMojang : PlayerConnection {
    public static func == (lhs: PlayerConnectionMojang, rhs: PlayerConnectionMojang) -> Bool {
        return lhs.player_uuid == rhs.player_uuid
    }
    
    public var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
    
    public let player_uuid:UUID
    public var socket:URLSessionWebSocketTask
    public internal(set) var ping:UInt16
    
    init(player_uuid: UUID, _ url: String) {
        self.player_uuid = player_uuid
        socket = URLSession.shared.webSocketTask(with: URL(string: url)!)
        socket.resume()
        ping = 0
        Task {
            await self.process_packets()
        }
    }
    
    private func receive() async throws -> URLSessionWebSocketTask.Message? {
        return try await socket.receive()
    }
    private func send(_ message: URLSessionWebSocketTask.Message) async throws {
        try await socket.send(message)
    }
    
    public func close(reason: Data?) {
        socket.cancel(with: .normalClosure, reason: reason)
        socket.cancel()
    }
    
    public func update_ping() {
        socket.sendPing { error in
            self.ping = UInt16.random(in: 0...UInt16.max)
        }
    }
    
    public func send_packet(_ packet: any Packet) async throws {
        let encoder:JSONEncoder = JSONEncoder()
        let data:Data = try encoder.encode(packet)
        let message:URLSessionWebSocketTask.Message = .data(data)
        try await send(message)
    }
    
    private func process_packets() async {
        do {
            guard let message:URLSessionWebSocketTask.Message = try await receive() else { return }
            process_packet(message)
        } catch {
            print("PlayerConnectionMojang;encountered error while trying to `process_packets` (\(error)")
        }
        Task {
            await process_packets()
        }
    }
    private func process_packet(_ packet: URLSessionWebSocketTask.Message) {
        switch packet {
        case .data(let data):
            print("PlayerConnectionMojang;process_packet;player_uuid=\(player_uuid);data=\(data)")
            break
        case .string(let string):
            print("PlayerConnectionMojang;process_packet;player_uuid=\(player_uuid);string=" + string)
            break
        @unknown default:
            break
        }
    }
}
