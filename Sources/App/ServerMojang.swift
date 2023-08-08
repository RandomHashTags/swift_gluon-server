//
//  ServerMojang.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation
import NIO

public final class ServerMojang {
    private let group:MultiThreadedEventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    let host:String
    let port:Int
    
    private var boostrap : ServerBootstrap {
        return ServerBootstrap(group: group)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .childChannelInitializer { channel in
                return channel.pipeline.addHandlers([BackPressureHandler(), ServerMojangHandler()])
            }
            .childChannelOption(ChannelOptions.socket(IPPROTO_TCP, TCP_NODELAY), value: 1)
            .childChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
            .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())
    }
    
    public init(host: String, port: Int) {
        self.host = host
        self.port = port
    }
    
    public func run() throws {
        print("ServerMojang;running on host \"" + host + "\" and port \(port)")
        let channel = try boostrap.bind(host: host, port: port).wait()
        try channel.closeFuture.wait()
    }
    
    public func shutdown() {
        print("ServerMojang;shutdown")
        do {
            try group.syncShutdownGracefully()
        } catch {
            exit(0)
        }
    }
}

final class ServerMojangHandler : ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    typealias OutboundOut = ByteBuffer
    
    var state:ServerMojangStatus = .handshaking
    var readable_bytes:[UInt8] = []
    
    func channelActive(context: ChannelHandlerContext) {
        print("ServerMojang;channelActive")
    }
    func channelRegistered(context: ChannelHandlerContext) {
        print("ServerMojang;channelRegistered;state=\(state);context=\(context)")
        
        switch state {
        case .handshaking:
            state = .handshaking_received_packet
            break
        case .handshaking_received_packet:
            context.read()
            break
        case .status:
            print("ServerMojang;channelRegistered;state==status")
            break
        default:
            let response:String = "bro"
            var buffer:ByteBuffer = context.channel.allocator.buffer(capacity: response.utf8.count)
            buffer.writeString(response)
            context.writeAndFlush(self.wrapOutboundOut(buffer)).whenComplete { _ in
                context.close(promise: nil)
            }
            break
        }
    }
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        print("ServerMojang;channelRead;data=\(data)")
        
        var buffer:ByteBuffer = unwrapInboundIn(data)
        guard let bytes:[UInt8] = buffer.readBytes(length: buffer.readableBytes) else {
            print("ServerMojang;channelRead;failed to read bytes")
            return
        }
        switch state {
        case .handshaking_received_packet:
            do {
                try parse_handshake(context: context, bytes: bytes)
            } catch {
                print("ServerMojang;channelRead;error=\(error)")
            }
            break
        default:
            for byte in bytes {
                print("ServerMojang;channelRead;byte=\(byte)")
            }
            break
        }
    }
    func channelReadComplete(context: ChannelHandlerContext) {
        print("ServerMojang;channelReadComplete")
    }
    
    func userInboundEventTriggered(context: ChannelHandlerContext, event: Any) {
        print("ServerMojang;userInboundEventTriggered")
    }
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("ServerMojang;errorCaught")
        context.close(promise: nil)
    }
    
    private func parse_handshake(context: ChannelHandlerContext, bytes: [UInt8]) throws {
        let packet:GeneralPacketMojang = try GeneralPacketMojang(bytes: bytes)
        guard let test:ServerPacketMojangHandshaking = ServerPacketMojangHandshaking(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojang;parse_handshake;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        let handshake_packet:any ServerPacketMojangHandshakingProtocol.Type = test.packet
        let client_packet:any ServerPacketMojangHandshakingProtocol = try handshake_packet.parse(packet)
        if let handshake:ServerPacketMojang.Handshaking.Handshake = client_packet as? ServerPacketMojang.Handshaking.Handshake {
            let next_state:ServerPacketMojang.Status = handshake.next_state
            print("ServerMojang;parse_handshake;success;handshake;protocol_version=\(handshake.protocol_version);server_address=" + handshake.server_address + ";server_port=\(handshake.server_port);next_state=\(next_state)")
            switch next_state {
            case .status:
                state = ServerMojangStatus.status
                let status_request:ServerPacketMojang.Status.StatusRequest = ServerPacketMojang.Status.StatusRequest()
                
                break
            case .login:
                break
            }
            
        }
    }
}

enum ServerMojangStatus {
    case handshaking
    case handshaking_received_packet
    case login
    case status
    case play
}