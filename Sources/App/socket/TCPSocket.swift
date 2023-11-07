//
//  TCPSocket.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

final class TCPSocket : Hashable {
    static func == (lhs: TCPSocket, rhs: TCPSocket) -> Bool {
        return lhs.socket_id == rhs.socket_id && lhs.port == rhs.port
    }
    
    var socket_id:Int32 = -1
    let port:UInt16
    
    private var listening_for_clients:Bool = false
    private var listening_for_clients_continuation:CheckedContinuation<TCPSocketClient, Never>! = nil
    fileprivate var connections:Set<TCPSocketClient> = []
    
    init(port: UInt16) {
        self.port = port
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(socket_id)
        hasher.combine(port)
    }
    
    func start() async {
        socket_id = socket(AF_INET, SOCK_STREAM, 0)
        if socket_id == -1 {
            perror("Failure: creating socket")
            exit(EXIT_FAILURE)
        }
        
        var sock_opt_on = Int32(1)
        setsockopt(socket_id, SOL_SOCKET, SO_REUSEADDR, &sock_opt_on, socklen_t(MemoryLayout.size(ofValue: sock_opt_on)))
        
        var server_addr = sockaddr_in()
        let server_addr_size = socklen_t(MemoryLayout.size(ofValue: server_addr))
        server_addr.sin_len = UInt8(server_addr_size)
        server_addr.sin_family = sa_family_t(AF_INET) // chooses IPv4
        server_addr.sin_port = port.bigEndian // chooses the port
        
        let bind_server = withUnsafePointer(to: &server_addr) {
            bind(socket_id, UnsafeRawPointer($0).assumingMemoryBound(to: sockaddr.self), server_addr_size)
        }
        if bind_server == -1 {
            perror("Failure: binding port")
            exit(EXIT_FAILURE)
        }
        
        if listen(socket_id, 5) == -1 {
            perror("Failure: listening")
            exit(EXIT_FAILURE)
        }
        
        var client_addr = sockaddr_storage()
        var client_addr_len = socklen_t(MemoryLayout.size(ofValue: client_addr))
        let client_fd = withUnsafeMutablePointer(to: &client_addr) {
            accept(socket_id, UnsafeMutableRawPointer($0).assumingMemoryBound(to: sockaddr.self), &client_addr_len)
        }
        if client_fd == -1 {
            perror("Failure: accepting connection")
            exit(EXIT_FAILURE)
        }
        
        await listen_for_clients()
    }
    func shutdown() {
        listening_for_clients = false
        listening_for_clients_continuation.resume(returning: TCPSocketClient(server: self, id: -1, payload: []))
        listening_for_clients_continuation = nil
        
        for connection in connections {
            connection.close()
        }
    }
    
    func listen_for_clients() async {
        listening_for_clients = true
        while listening_for_clients {
            let client:TCPSocketClient = await withCheckedContinuation { continuation in
                listening_for_clients_continuation = continuation
                var client_addr:sockaddr_storage = sockaddr_storage()
                var client_addr_len = socklen_t(MemoryLayout.size(ofValue: client_addr))
                
                let client_fd = withUnsafeMutablePointer(to: &client_addr) {
                    accept(socket_id, UnsafeMutableRawPointer($0).assumingMemoryBound(to: sockaddr.self), &client_addr_len)
                }
                let payload:[CChar] = [client_addr.__ss_pad1.0, client_addr.__ss_pad1.1, client_addr.__ss_pad1.2, client_addr.__ss_pad1.3, client_addr.__ss_pad1.4, client_addr.__ss_pad1.5]
                let client:TCPSocketClient = TCPSocketClient(server: self, id: client_fd, payload: payload)
                connections.insert(client)
                print("Connected with id \(client_fd);client_addr=\(client_addr);client_addr_len=\(client_addr_len);payload=\(payload)")
                continuation.resume(returning: client)
            }
        }
    }
}

struct TCPSocketClient : Hashable {
    let server:TCPSocket
    let id:Int32
    let payload:[Int8]
    
    func close() {
        server.connections.remove(self)
        Darwin.close(id)
    }
}

enum TCPSocketAddressFamily : Int {
    case ipv4
    case ipv6
}
