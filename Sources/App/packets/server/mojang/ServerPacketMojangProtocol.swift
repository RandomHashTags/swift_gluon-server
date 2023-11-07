//
//  ServerPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ServerPacketMojangProtocol : ServerPacket, PacketMojang {
    associatedtype GameplayID : PacketGameplayID
    
    static var packet_gameplay_id : GameplayID.Type { get }
    
    static var id : GameplayID { get }
}
public extension ServerPacketMojangProtocol {
    func as_client_response() throws -> Data {
        let packet_id:VariableInteger = VariableInteger(value: Int32(Self.id.rawValue))
        let packet_id_bytes:[UInt8] = try packet_id.packet_bytes()
        let packet_bytes:[UInt8] = try packet_bytes()
        
        let length:Int = packet_id_bytes.count + packet_bytes.count
        var bytes:[UInt8] = try VariableInteger(value: Int32(length)).packet_bytes()
        bytes.append(contentsOf: packet_id_bytes)
        bytes.append(contentsOf: packet_bytes)
        return Data(bytes)
    }
}

// MARK: ServerPacketMojangHandshakingProtocol
public protocol ServerPacketMojangHandshakingProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangHandshaking {
}
public extension ServerPacketMojangHandshakingProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangHandshaking.self
        }
    }
}
public extension ServerPacketMojangHandshakingProtocol {
    var category : Category {
        return Category.server_handshaking
    }
}

// MARK: ServerPacketMojangPlayProtocol
public protocol ServerPacketMojangLoginProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangLogin {
}
public extension ServerPacketMojangLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangLogin.self
        }
    }
}
public extension ServerPacketMojangLoginProtocol {
    var category : Category {
        return Category.server_login
    }
}

// MARK: ServerPacketMojangPlayProtocol
public protocol ServerPacketMojangPlayProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangPlay {
}
public extension ServerPacketMojangPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangPlay.self
        }
    }
}
public extension ServerPacketMojangPlayProtocol {
    var category : Category {
        return Category.server_play
    }
}

// MARK: ServerPacketMojangStatusProtocol
public protocol ServerPacketMojangStatusProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangStatus {
}
public extension ServerPacketMojangStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangStatus.self
        }
    }
}
public extension ServerPacketMojangStatusProtocol {
    var category : Category {
        return Category.server_status
    }
}
