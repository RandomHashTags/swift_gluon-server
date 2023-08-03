//
//  PlayerConnection.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class PlayerConnection {
    public static func == (lhs: PlayerConnection, rhs: PlayerConnection) -> Bool {
        return lhs.player_uuid == rhs.player_uuid
    }
    
    private let player_uuid:UUID
    private var socket:URLSessionWebSocketTask
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
    
    func close() {
        socket.cancel(with: .normalClosure, reason: nil)
        socket.cancel()
    }
    
    func update_ping() {
        socket.sendPing { error in
            self.ping = UInt16.random(in: 0...UInt16.max)
        }
    }
    
    private func process_packets() async {
        do {
            guard let message:URLSessionWebSocketTask.Message = try await receive() else { return }
            process_packet(message)
        } catch {
            print("PlayerConnection;encountered error while trying to `process_packets` (\(error)") // TODO: handle
        }
        Task {
            await process_packets()
        }
    }
    private func process_packet(_ packet: URLSessionWebSocketTask.Message) {
        switch packet {
        case .data(let data):
            print("PlayerConnection;process_packet;player_uuid=\(player_uuid);data=\(data)")
            break
        case .string(let string):
            print("PlayerConnection;process_packet;player_uuid=\(player_uuid);string=" + string)
            break
        @unknown default:
            break
        }
    }
}
