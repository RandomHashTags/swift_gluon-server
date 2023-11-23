//
//  ServerMojangClient.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation
import Socket
import SwiftASN1

public final class ServerMojangClient : Hashable {
    public static func == (lhs: ServerMojangClient, rhs: ServerMojangClient) -> Bool {
        return lhs.socket == rhs.socket && lhs.state == rhs.state
    }
    
    private let socket:Socket, onClose:(ServerMojangClient) -> Void
    
    public private(set) var state:ServerMojangStatus = .handshaking_received_packet
    public private(set) var protocol_version:MinecraftProtocolVersion = MinecraftProtocolVersion.unknown
    public private(set) var information:ServerPacketMojang.Configuration.ClientInformation?
    private var player_builder:PlayerBuilder!
    public private(set) var player:(any Player)?
    private var connection_task:Task<Void, Never>!
    
    init(socket: Socket, onClose: @escaping (ServerMojangClient) -> Void) {
        self.socket = socket
        self.onClose = onClose
        
        connection_task = Task {
            while socket.isActive {
                do {
                    try process_packet()
                } catch {
                    print("ServerMojangClient;process_packet;error=\(error)")
                }
            }
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(socket)
        hasher.combine(state)
    }
    
    func process_packet() throws {
        switch state {
        case .handshaking_received_packet:
            try parse_handshake()
            break
        case .status:
            try parse_status()
            break
        case .login:
            try parse_login()
            break
        case .configuration:
            try parse_configuration()
            break
        case .play:
            try parse_play()
            break
        default:
            print("ServerMojangClient;default;test;state=\(state)")
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
        guard let handshake:ServerPacketMojang.Handshaking.Handshake = client_packet as? ServerPacketMojang.Handshaking.Handshake else { return }
        let next_state:ServerPacketMojang.Status = handshake.next_state
        protocol_version = handshake.protocol_version
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
    
    private func parse_status() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangStatus = ServerPacketMojangStatus(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_status;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClient;parse_status;test=\(test)")
        let ping_request:ServerPacketMojang.Status.PingRequest
        switch test {
        case .ping_request:
            ping_request = try ServerPacketMojang.Status.PingRequest.parse(packet)
            break
        case .status_request:
            let status_request:ServerPacketMojang.Status.StatusRequest = try ServerPacketMojang.Status.StatusRequest.parse(packet)
            let status_response:ClientPacketMojang.Status.StatusResponse = try ClientPacketMojang.Status.StatusResponse(
                version: protocol_version,
                motd: "Test bruh; your Minecraft Protocol Version == \(protocol_version)",
                enforces_secure_chat: true,
                online_players_count: ServerMojang.instance.player_connections.count
            )
            try socket.send_packet(status_response)
            
            packet = try read_packet()
            ping_request = try ServerPacketMojang.Status.PingRequest.parse(packet)
            break
        }
        let ping_response:ClientPacketMojang.Status.PingResponse = ClientPacketMojang.Status.PingResponse(payload: ping_request.payload)
        try socket.send_packet(ping_response)
        close()
    }
    private func parse_login() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangLogin = ServerPacketMojangLogin(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_login;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClient;parse_login;test=\(test)")
        let login_start_packet:ServerPacketMojang.Login.LoginStart = try ServerPacketMojang.Login.LoginStart.parse(packet)
        player_builder = PlayerBuilder(uuid: login_start_packet.player_uuid, name: login_start_packet.name)
        
        switch test {
        case .login_start:
            let online_mode:Bool = false
            if online_mode {
                let public_key:String = ServerMojang.public_key
                
                //var bruh = DER.Serializer()
                //bruh.serialize(SubjectPublicKeyInfo(algorithm: SubjectPublicKeyInfo.Algorithm, subjectPublicKey: <#T##ArraySlice<UInt8>#>))
                
                let yoink:String = "-----BEGIN PUBLIC KEY-----\n" + public_key + "\n-----END PUBLIC KEY-----"
                let public_key_bytes:[UInt8] = [UInt8](yoink.utf8)
                
                let verify_token:[UInt8] = [UInt8.random(), UInt8.random(), UInt8.random(), UInt8.random()]
                let encryption_request:ClientPacketMojang.Login.EncryptionRequest = ClientPacketMojang.Login.EncryptionRequest(
                    server_id: "",
                    public_key: public_key_bytes,
                    verify_token: verify_token
                )
                try socket.send_packet(encryption_request)
                
                print("test1")
                packet = try read_packet()
                print("test2")
                let um:ServerPacketMojang.Login.EncryptionResponse = try ServerPacketMojang.Login.EncryptionResponse.parse(packet)
                print("test3")
            } else {
                let success_packet:ClientPacketMojang.Login.LoginSuccess = ClientPacketMojang.Login.LoginSuccess(
                    uuid: login_start_packet.player_uuid,
                    username: login_start_packet.name,
                    number_of_properties: VariableInteger(value: 0),
                    properties: []
                )
                try socket.send_packet(success_packet)
                
                packet = try read_packet() // acknowledged packet
            }
            state = .configuration
            break
        case .encryption_response:
            break
        case .login_acknowledged:
            break
            
        case .login_plugin_response:
            break
        }
    }
    
    private func parse_configuration() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangConfiguration = ServerPacketMojangConfiguration(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_configuration;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClient;parse_configuration;test=\(test)")
        switch test {
        case .client_information:
            information = try ServerPacketMojang.Configuration.ClientInformation.parse(packet)
            break
        default:
            break
        }
        
        let finish_configuration:ServerPacketMojang.Configuration.FinishConfiguration = ServerPacketMojang.Configuration.FinishConfiguration()
        try socket.send_packet(finish_configuration)
        
        state = .play
        player = GluonPlayer(
            name: player_builder.name,
            experience: 0,
            experience_level: 0,
            food_data: <#T##FoodData#>,
            permissions: [],
            statistics: [:],
            game_mode: DefaultGameModes.survival,
            is_blocking: false,
            is_flying: false,
            is_op: false,
            is_sneaking: false,
            is_sprinting: false,
            inventory: <#T##PlayerInventory#>,
            can_breathe_underwater: false,
            can_pickup_items: true,
            has_ai: false,
            is_climbing: false,
            is_collidable: true,
            is_gliding: false,
            is_invisible: false,
            is_leashed: false,
            is_riptiding: false,
            is_sleeping: false,
            is_swimming: false,
            potion_effects: [:],
            no_damage_ticks: 0,
            no_damage_ticks_maximum: 20,
            air_remaining: 20,
            air_maximum: 20,
            health: 20,
            health_maximum: 20,
            
            uuid: player_builder.uuid,
            type_id: "minecraft:player",
            ticks_lived: 0,
            boundaries: [],
            location: <#T##Location#>,
            velocity: Vector(x: 0, y: 0, z: 0),
            fall_distance: 0,
            is_glowing: false,
            is_on_fire: false,
            is_on_ground: true,
            height: 0,
            fire_ticks: 0,
            fire_ticks_maximum: 0,
            freeze_ticks: 0,
            freeze_ticks_maximum: 0,
            passenger_uuids: [],
            vehicle_uuid: nil
        )
        ServerMojang.instance.upgrade(connection: self)
    }
    
    private func parse_play() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacketMojangPlay = ServerPacketMojangPlay(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClient;parse_play;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClient;parse_play;test=\(test)")
        test.process(self)
    }
    
    func send_packet(_ packet: any PacketMojang) throws {
        try socket.send_packet(packet)
    }
}

extension Socket {
    func send_packet(_ packet: any PacketMojang) throws {
        let data:Data = try packet.as_client_response()
        try write(from: data)
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

public enum ServerMojangStatus {
    case handshaking
    case handshaking_received_packet
    case login
    case configuration
    case status
    case play
}

struct PlayerBuilder {
    var uuid:UUID
    var name:String
}

struct SubjectPublicKeyInfo : DERImplicitlyTaggable {
    static let defaultIdentifier:ASN1Identifier = ASN1Identifier.sequence
    
    var algorithm:Algorithm
    var subjectPublicKey:ArraySlice<UInt8>
    
    init(algorithm: Algorithm, subjectPublicKey: ArraySlice<UInt8>) {
        self.algorithm = algorithm
        self.subjectPublicKey = subjectPublicKey
    }
    
    init(derEncoded: ASN1Node, withIdentifier identifier: ASN1Identifier) throws {
        self = try DER.sequence(derEncoded, identifier: identifier, { nodes in
            let algorithm:Algorithm = try Algorithm(derEncoded: &nodes)
            let subjectPublicKey:ArraySlice<UInt8> = try ArraySlice<UInt8>(derEncoded: &nodes)
            return SubjectPublicKeyInfo(algorithm: algorithm, subjectPublicKey: subjectPublicKey)
        })
    }
    
    func serialize(into coder: inout DER.Serializer, withIdentifier identifier: ASN1Identifier) throws {
        try coder.appendConstructedNode(identifier: identifier) { coder in
            try coder.serialize(self.algorithm)
            try coder.serialize(self.subjectPublicKey)
        }
    }
    
    struct Algorithm : DERImplicitlyTaggable {
        static let defaultIdentifier:ASN1Identifier = ASN1Identifier.sequence
        
        let algorithm:ArraySlice<UInt8>
        let parameters:ArraySlice<UInt8>
        
        init(algorithm: ArraySlice<UInt8>, parameters: ArraySlice<UInt8>) {
            self.algorithm = algorithm
            self.parameters = parameters
        }
        
        init(derEncoded: ASN1Node, withIdentifier identifier: ASN1Identifier) throws {
            self = try DER.sequence(derEncoded, identifier: identifier, { nodes in
                let algorithm:ArraySlice<UInt8> = try ArraySlice<UInt8>(derEncoded: &nodes)
                let subjectPublicKey:ArraySlice<UInt8> = try ArraySlice<UInt8>(derEncoded: &nodes)
                return Algorithm(algorithm: algorithm, parameters: subjectPublicKey)
            })
        }
        
        func serialize(into coder: inout DER.Serializer, withIdentifier identifier: ASN1Identifier) throws {
            try coder.appendConstructedNode(identifier: identifier) { coder in
                try coder.serialize(self.algorithm)
                try coder.serialize(self.parameters)
            }
        }
    }
}

struct SubjectPublicKey : DERImplicitlyTaggable {
    static let defaultIdentifier:ASN1Identifier = ASN1Identifier.sequence
    
    let modulus:Int
    let publicExponent:Int
    
    init(modulus: Int, publicExponent: Int) {
        self.modulus = modulus
        self.publicExponent = publicExponent
    }
    
    init(derEncoded: ASN1Node, withIdentifier identifier: ASN1Identifier) throws {
        self = try DER.sequence(derEncoded, identifier: identifier, { nodes in
            let modulus:Int = try Int(derEncoded: &nodes)
            let publicExponent:Int = try Int(derEncoded: &nodes)
            return SubjectPublicKey(modulus: modulus, publicExponent: publicExponent)
        })
    }
    
    func serialize(into coder: inout DER.Serializer, withIdentifier identifier: ASN1Identifier) throws {
        try coder.appendConstructedNode(identifier: identifier) { coder in
            try coder.serialize(self.modulus)
            try coder.serialize(self.publicExponent)
        }
    }
}
