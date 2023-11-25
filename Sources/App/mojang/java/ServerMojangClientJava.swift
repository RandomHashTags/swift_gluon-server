//
//  ServerMojangClientJava.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation
import Socket
import SwiftASN1

final class ServerMojangClientJava : MinecraftClientHandler {
    public static let platform:PacketPlatform = PacketPlatform.mojang_java
    
    public static func == (lhs: ServerMojangClientJava, rhs: ServerMojangClientJava) -> Bool {
        return lhs.socket == rhs.socket && lhs.state == rhs.state
    }
    
    public typealias ProtocolVersion = MinecraftProtocolVersion.Java
    public typealias PlayerType = GluonPlayer
    
    
    internal let socket:Socket
    
    public private(set) var state:ServerMojangStatus = .handshaking_received_packet
    public private(set) var protocol_version:ProtocolVersion = ProtocolVersion.unknown
    public private(set) var information:ServerPacket.Mojang.Java.Configuration.ClientInformation?
    private var player_builder:PlayerBuilder!
    public private(set) var player:PlayerType?
    private var connection_task:Task<Void, Never>!
    
    init(socket: Socket) {
        self.socket = socket
        connection_task = Task {
            while socket.isActive {
                do {
                    try process_packet()
                } catch {
                    print("ServerMojangClientJava;process_packet;error=\(error)")
                }
            }
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(socket)
        hasher.combine(state)
    }
    
    public func process_packet() throws {
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
            print("ServerMojangClientJava;default;test;state=\(state)")
            break
        }
    }
    func read_packet() throws -> GeneralPacketMojang {
        var data:Data = Data()
        let _:Int = try socket.read(into: &data)
        let bytes:[UInt8] = [UInt8](data)
        return try GeneralPacketMojang(bytes: bytes)
    }
    func read_and_parse_mojang_packet<T: PacketMojangJava>() throws -> T {
        let general_packet:GeneralPacketMojang = try read_packet()
        return try T.parse(general_packet)
    }
    
    public func close() {
        connection_task.cancel()
        ServerMojang.instance.close(connection: self)
    }
    
    private func parse_handshake() throws {
        let packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacket.Mojang.Java.Handshaking = ServerPacket.Mojang.Java.Handshaking(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClientJava;parse_handshake;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        let handshake_packet:any ServerPacketMojangJavaHandshakingProtocol.Type = test.packet
        let client_packet:any ServerPacketMojangJavaHandshakingProtocol = try handshake_packet.parse(packet)
        guard let handshake:ServerPacket.Mojang.Java.Handshaking.Handshake = client_packet as? ServerPacket.Mojang.Java.Handshaking.Handshake else { return }
        let next_state:ServerPacket.Mojang.Java.Handshaking.Handshake.State = handshake.next_state
        protocol_version = handshake.protocol_version
        print("ServerMojangClientJava;parse_handshake;success;handshake;protocol_version=\(handshake.protocol_version);server_address=" + handshake.server_address + ";server_port=\(handshake.server_port);next_state=\(next_state)")
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
        guard let test:ServerPacket.Mojang.Java.Status = ServerPacket.Mojang.Java.Status(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClientJava;parse_status;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClientJava;parse_status;test=\(test)")
        let ping_request:ServerPacket.Mojang.Java.Status.PingRequest
        switch test {
        case .ping_request:
            ping_request = try ServerPacket.Mojang.Java.Status.PingRequest.parse(packet)
            break
        case .status_request:
            let status_request:ServerPacket.Mojang.Java.Status.StatusRequest = try ServerPacket.Mojang.Java.Status.StatusRequest.parse(packet)
            let status_response:ClientPacket.Mojang.Java.Status.StatusResponse = try ClientPacket.Mojang.Java.Status.StatusResponse(
                version: protocol_version,
                motd: "Test bruh; your Minecraft Protocol Version == \(protocol_version)",
                enforces_secure_chat: true,
                online_players_count: ServerMojang.instance.player_connections.count
            )
            try send_packet(status_response)
            
            packet = try read_packet()
            ping_request = try ServerPacket.Mojang.Java.Status.PingRequest.parse(packet)
            break
        }
        let ping_response:ClientPacket.Mojang.Java.Status.PingResponse = ClientPacket.Mojang.Java.Status.PingResponse(payload: ping_request.payload)
        try send_packet(ping_response)
        close()
    }
    private func parse_login() throws {
        var packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClientJava;parse_login;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClientJava;parse_login;test=\(test)")
        let login_start_packet:ServerPacket.Mojang.Java.Login.LoginStart = try ServerPacket.Mojang.Java.Login.LoginStart.parse(packet)
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
                let encryption_request:ClientPacket.Mojang.Java.Login.EncryptionRequest = ClientPacket.Mojang.Java.Login.EncryptionRequest(
                    server_id: "",
                    public_key: public_key_bytes,
                    verify_token: verify_token
                )
                try send_packet(encryption_request)
                
                print("test1")
                packet = try read_packet()
                print("test2")
                let um:ServerPacket.Mojang.Java.Login.EncryptionResponse = try ServerPacket.Mojang.Java.Login.EncryptionResponse.parse(packet)
                print("test3")
            } else {
                let success_packet:ClientPacket.Mojang.Java.Login.LoginSuccess = ClientPacket.Mojang.Java.Login.LoginSuccess(
                    uuid: login_start_packet.player_uuid,
                    username: login_start_packet.name,
                    number_of_properties: VariableIntegerJava(value: 0),
                    properties: []
                )
                try send_packet(success_packet)
                
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
        guard let test:ServerPacket.Mojang.Java.Configuration = ServerPacket.Mojang.Java.Configuration(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClientJava;parse_configuration;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClientJava;parse_configuration;test=\(test)")
        switch test {
        case .client_information:
            information = try ServerPacket.Mojang.Java.Configuration.ClientInformation.parse(packet)
            break
        default:
            break
        }
        
        let finish_configuration:ServerPacket.Mojang.Java.Configuration.FinishConfiguration = ServerPacket.Mojang.Java.Configuration.FinishConfiguration()
        try send_packet(finish_configuration)
        
        state = .play
        let uuid:UUID = player_builder.uuid
        let world:any World = GluonServer.shared_instance.worlds.first!.value
        let food_data:GluonFoodData = GluonFoodData(food_level: 10, saturation_level: 0, exhaustion_level: 0)
        let inventory_type:GluonInventoryType = GluonInventoryType(id: "minecraft:player", categories: [], size: 36, material_category_restrictions: [:], material_retrictions: [:], allowed_recipe_ids: [])
        let inventory:GluonPlayerInventory = GluonPlayerInventory(type: inventory_type, held_item_slot: 0, items: [], viewers: [])
        player = GluonPlayer(
            name: player_builder.name,
            experience: 0,
            experience_level: 0,
            food_data: food_data,
            permissions: [],
            statistics: [:],
            game_mode: DefaultGameModes.survival,
            is_blocking: false,
            is_flying: false,
            is_op: false,
            is_sneaking: false,
            is_sprinting: false,
            inventory: inventory,
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
            
            uuid: uuid,
            type_id: "minecraft:player",
            ticks_lived: 0,
            boundaries: [],
            location: GluonLocation(world: world, x: 0, y: 0, z: 0, yaw: 0, pitch: 0),
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
        ServerMojang.instance.upgrade(uuid: uuid, connection: self)
    }
    
    private func parse_play() throws {
        let packet:GeneralPacketMojang = try read_packet()
        guard let test:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play(rawValue: UInt8(packet.packet_id.value)) else {
            print("ServerMojangClientJava;parse_play;failed to find packet with id \(packet.packet_id.value)")
            return
        }
        print("ServerMojangClientJava;parse_play;test=\(test)")
        try test.server_received(self)
    }
    
    public func send_packet(_ packet: any PacketMojangJava) throws {
        let data:Data = try packet.as_client_response()
        try send_packet_data(data)
    }
    public func send_packet_data(_ packet_data: Data) throws {
        try socket.write(from: packet_data)
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
