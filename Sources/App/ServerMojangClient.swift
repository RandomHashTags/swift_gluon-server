//
//  ServerMojangClient.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation
import Socket
import SwiftASN1

final class ServerMojangClient : Hashable {
    static func == (lhs: ServerMojangClient, rhs: ServerMojangClient) -> Bool {
        return lhs.socket == rhs.socket && lhs.state == rhs.state
    }
    
    let socket:Socket, onClose:(ServerMojangClient) -> Void
    private(set) var state:ServerMojangStatus = .handshaking_received_packet
    private var connection_task:Task<Void, Never>!
    
    init(socket: Socket, onClose: @escaping (ServerMojangClient) -> Void) {
        self.socket = socket
        self.onClose = onClose
        
        connection_task = Task {
            while socket.isActive {
                try! process_packet()
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(socket)
        hasher.combine(state)
    }
    
    func process_packet() throws {
        switch state {
        case .handshaking_received_packet:
            do {
                try parse_handshake()
            } catch {
                print("ServerMojangClient;test;error=\(error)")
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
            /*do {
                let data:Data = try JSONEncoder().encode(status_request)
                let string:String = String(data: data, encoding: .utf8)!
                write(context: context, bytes: try string.packet_bytes()) {
                    print("ServerMojang;channelRead;state==.status;write onComplete, reading...")
                    context.read()
                }
            } catch {
                print("ServerMojang;channelRead;state==.status;error=\(error)")
            }*/
            break
        case .login:
            do {
                try parse_login()
            } catch {
                print("ServerMojangClient;test;error=\(error)")
            }
            break
        default:
            print("ServerMojangClient;test;state=\(state)")
            break
        }
    }
    func read_packet() throws -> GeneralPacketMojang {
        var data:Data = Data()
        let _:Int = try socket.read(into: &data)
        let bytes:[UInt8] = [UInt8](data)
        return try GeneralPacketMojang(bytes: bytes)
    }
    
    func close() {
        onClose(self)
        connection_task.cancel()
        socket.close()
    }
    
    private func parse_handshake() throws {
        let packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangHandshaking = ServerPacketMojangHandshaking(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_handshake;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        let handshake_packet:any ServerPacketMojangHandshakingProtocol.Type = test.packet
        let client_packet:any ServerPacketMojangHandshakingProtocol = try handshake_packet.parse(packet)
        if let handshake:ServerPacketMojang.Handshaking.Handshake = client_packet as? ServerPacketMojang.Handshaking.Handshake {
            let next_state:ServerPacketMojang.Status = handshake.next_state
            print("ServerMojangClient;parse_handshake;success;handshake;protocol_version=\(handshake.protocol_version);server_address=" + handshake.server_address + ";server_port=\(handshake.server_port);next_state=\(next_state)")
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
    private func parse_login() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangLogin = ServerPacketMojangLogin(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_login;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClient;parse_login;test=\(test)")
        let login_start_packet:ServerPacketMojang.Login.LoginStart = try ServerPacketMojang.Login.LoginStart.parse(packet)
        switch test {
        case .login_start:
            let public_key:SecKey = ServerMojang.public_key
            
            let public_key_data:Data = try public_key.data()
            let public_key_bytes:[UInt8] = [UInt8](public_key_data)
            
            let poop:ASN1Node = try DER.parse(public_key_bytes)
            
            print("ServerMojangClient;parse_login;public_key_bytes.count=\(public_key_bytes.count);poop.encoded_bytes.count=\(poop.encodedBytes.count)")
            
            let verify_token:[UInt8] = [UInt8.random(), UInt8.random(), UInt8.random(), UInt8.random()]
            let encryption_request:ClientPacketMojang.Login.EncryptionRequest = ClientPacketMojang.Login.EncryptionRequest(
                server_id: "",
                public_key_length: VariableInteger(value: Int32(public_key_bytes.count)),
                public_key: public_key_bytes,
                verify_token_length: VariableInteger(value: Int32(verify_token.count)),
                verify_token: verify_token
            )
            let data:Data = try encryption_request.as_client_response()
            try socket.write(from: data)
            
            print("test1")
            packet = try read_packet()
            print("test2")
            let um:ServerPacketMojang.Login.EncryptionResponse = try ServerPacketMojang.Login.EncryptionResponse.parse(packet)
            print("test3")
            break
        case .encryption_response:
            break
        case .login_acknowledged:
            break
            
        case .login_plugin_response:
            break
        }
    }
}

struct ServerPacketMojangStatusResponse : Codable {
    let version:Version
    let players:Players
    let description:ChatPacketMojang
    let favicon:String?
    let enforcesSecureChat:Bool
    let previewsChat:Bool
    
    struct Version : Codable {
        let name:String
        let `protocol`:Int
    }
    struct Players : Codable {
        let max:Int
        let online:Int
        let sample:[Player]?
    }
    struct Player : Codable {
        let name:String
        let id:UUID
    }
}

enum ServerMojangStatus {
    case handshaking
    case handshaking_received_packet
    case login
    case status
    case play
}
