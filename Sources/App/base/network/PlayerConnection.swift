//
//  PlayerConnection.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class PlayerConnection {
    private var socket:URLSessionWebSocketTask
    public internal(set) var ping:UInt16
    
    init(_ url: String) {
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
            print("PlayerConnection;encountered error while trying to `process_packets` (\(error)")
        }
        Task {
            await process_packets()
        }
    }
    private func process_packet(_ packet: URLSessionWebSocketTask.Message) {
        switch packet {
        case .data(let data):
            break
        case .string(let string):
            break
        @unknown default:
            break
        }
    }
}
