//
//  ServerMojang.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation
import Socket
import SwiftASN1


// BlueSocket TCP Server
public final class ServerMojang {
    public private(set) static var instance:ServerMojang!
    public private(set) static var public_key:String!, private_key:String!
    
    let host:String
    let port:Int
    private(set) var connections:Set<ServerMojangClient>
    private(set) var player_connections:[UUID:ServerMojangClient]
    
    public init(host: String, port: Int) {
        self.host = host
        self.port = port
        
        connections = []
        player_connections = [:]
        ServerMojang.instance = self
    }
    
    public func run() throws {
        print("ServerMojang;running on host \"" + host + "\" and port \(port)")
        try generate_server_public_and_private_key()
        let socket:Socket = try Socket.create()
        try socket.listen(on: 25565)
        
        socket.readBufferSize = Socket.SOCKET_DEFAULT_READ_BUFFER_SIZE
        
        while true {
            let client_socket:Socket = try socket.acceptClientConnection()
            let id:Int32 = client_socket.socketfd
            print("id=\(id)")
            let client:ServerMojangClient = ServerMojangClient(socket: client_socket) { closed_client in
                self.connections.remove(closed_client)
            }
            connections.insert(client)
        }
    }
    
    internal func upgrade(uuid: UUID, connection: ServerMojangClient) {
        connections.remove(connection)
        player_connections[uuid] = connection
    }
    
    public func shutdown() {
        for connection in connections {
            connection.close()
        }
        let disconnect_packet:ClientPacketMojang.Play.Disconnect = ClientPacketMojang.Play.Disconnect(reason: ChatPacketMojang(text: "Server Closed.", translate: nil, with: nil, score: nil, bold: nil, italic: nil, underlined: nil, strikethrough: nil, obfuscated: nil, font: nil, color: nil, insertion: nil, clickEvent: nil, hoverEvent: nil, extra: nil))
        for (uuid, player_connection) in player_connections {
            do {
                try GluonServer.shared_instance.boot_player(disconnect_packet: disconnect_packet, player: player_connection.player!)
            } catch {
                print("ServerMojang;shutdown;encountered error while trying to kick player with uuid \(uuid): \(error)")
            }
            player_connection.close()
        }
        print("ServerMojang;shutdown")
    }
    
    private func generate_server_public_and_private_key() throws {
        let publicKeyAttr: [NSObject: NSObject] = [
                    kSecAttrIsPermanent: kCFBooleanFalse,
                    kSecAttrApplicationTag: "com.xeoscript.app.RsaFromScrach.public".data(using: String.Encoding.utf8)! as NSObject,
                    kSecClass: kSecClassKey, // added this value
                    kSecReturnData: kCFBooleanTrue] // added this value
        let privateKeyAttr: [NSObject: NSObject] = [
                    kSecAttrIsPermanent: kCFBooleanFalse,
                    kSecAttrApplicationTag: "com.xeoscript.app.RsaFromScrach.private".data(using: String.Encoding.utf8)! as NSObject,
                    kSecClass: kSecClassKey, // added this value
                    kSecReturnData: kCFBooleanTrue] // added this value
        var keyPairAttr = [NSObject: NSObject]()
        keyPairAttr[kSecAttrKeyType] = kSecAttrKeyTypeRSA
        keyPairAttr[kSecAttrKeySizeInBits] = 1024 as NSObject
        keyPairAttr[kSecPublicKeyAttrs] = publicKeyAttr as NSObject
        keyPairAttr[kSecAttrKeyClass] = kSecAttrKeyClassPublic
        keyPairAttr[kSecPrivateKeyAttrs] = privateKeyAttr as NSObject
        
        var error:Unmanaged<CFError>?
        guard let private_key:SecKey = SecKeyCreateRandomKey(keyPairAttr as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        guard let public_key:SecKey = SecKeyCopyPublicKey(private_key) else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "couldn't get public key from private key"))
        }
        (ServerMojang.public_key, ServerMojang.private_key) = try (public_key.data(), private_key.data())
        print("ServerMojang;generate_server_public_and_private_key;public_key.count=\(ServerMojang.public_key.count);public_key=\n" + ServerMojang.public_key)
    }
}
extension SecKey {
    func data() throws -> String {
        var error:Unmanaged<CFError>?
        guard let data:Data = SecKeyCopyExternalRepresentation(self, &error) as? Data else {
            throw error!.takeRetainedValue() as Error
        }
        return data.base64EncodedString()
    }
}

/*
// NIO Web Socket Server
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
        let channel:Channel = try boostrap.bind(host: host, port: port).wait()
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
    
    private func write_packet(context: ChannelHandlerContext, _ packet: any Packet, on_complete: (() -> Void)? = nil) throws {
        let bytes:[UInt8] = try packet.packet_bytes()
        print("ServerMojang;write_packet;packet.category=\(packet.category);bytes=" + bytes.debugDescription)
        let buffer:ByteBuffer = context.channel.allocator.buffer(bytes: bytes)
        context.write(self.wrapOutboundOut(buffer)).whenComplete { result in
            print("ServerMojang;write_packet;whenComplete;result=\(result)")
            on_complete?()
        }
    }
    private func write(context: ChannelHandlerContext, bytes: [UInt8], on_complete: (() -> Void)? = nil) {
        let buffer:ByteBuffer = context.channel.allocator.buffer(bytes: bytes)
        let out = wrapOutboundOut(buffer)
        context.write(out, promise: nil)
        /*.write(out).whenComplete { result in
            print("ServerMojang;write;whenComplete;result=\(result)")
            on_complete?()
        }*/
    }
    
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
            print("ServerMojang;channelRegistered;state==\(state);broke")
            break
        }
    }
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        print("ServerMojang;channelRead;state=\(state);data=\(data)")
        
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
        case .status:
            let version:MinecraftProtocolVersion = MinecraftProtocolVersion.v1_20_2
            let status_request:ServerPacketMojangStatusResponse = ServerPacketMojangStatusResponse(
                version: ServerPacketMojangStatusResponse.Version(name: version.name, protocol: version.rawValue),
                players: ServerPacketMojangStatusResponse.Players(max: 10, online: 1, sample: [ServerPacketMojangStatusResponse.Player(name: "thinkofdeath", id: UUID("4566e69f-c907-48ee-8d71-d7ba5aa00d20")!)]),
                description: ChatPacketMojang(text: "Hello world", translate: nil, with: nil, score: nil, bold: nil, italic: nil, underlined: nil, strikethrough: nil, obfuscated: nil, font: nil, color: nil, insertion: nil, clickEvent: nil, hoverEvent: nil, extra: nil),
                favicon: nil,
                enforcesSecureChat: true,
                previewsChat: true
            )
            do {
                let data:Data = try JSONEncoder().encode(status_request)
                let string:String = String(data: data, encoding: .utf8)!
                write(context: context, bytes: try string.packet_bytes()) {
                    print("ServerMojang;channelRead;state==.status;write onComplete, reading...")
                    context.read()
                }
            } catch {
                print("ServerMojang;channelRead;state==.status;error=\(error)")
            }
            break
        case .login:
            break
        default:
            print("ServerMojang;channelRead;state=\(state)")
            for byte in bytes {
                print("ServerMojang;channelRead;byte=\(byte)")
            }
            break
        }
    }
    func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
        print("ServerMojang;channelReadComplete")
    }
    
    func userInboundEventTriggered(context: ChannelHandlerContext, event: Any) {
        print("ServerMojang;userInboundEventTriggered")
    }
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("ServerMojang;errorCaught;error=\(error)")
        context.close(promise: nil)
    }
    
    func channelInactive(context: ChannelHandlerContext) {
        print("ServerMojang;channelInactive")
    }
    func channelUnregistered(context: ChannelHandlerContext) {
        print("ServerMojang;channelUnregistered")
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
                break
            case .login:
                state = ServerMojangStatus.login
                break
            }
        }
    }
}
*/
