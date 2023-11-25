//
//  ServerPacketMojangJavaProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ServerPacketMojangJavaProtocol : ServerPacketProtocol, PacketMojang {
}

// MARK: ServerPacketMojangJavaHandshakingProtocol
public protocol ServerPacketMojangJavaHandshakingProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Handshaking {
}
public extension ServerPacketMojangJavaHandshakingProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Handshaking.self
        }
    }
}
public extension ServerPacketMojangJavaHandshakingProtocol {
    var category : Category {
        return Category.server_handshaking
    }
}

// MARK: ServerPacketMojangJavaLoginProtocol
public protocol ServerPacketMojangJavaLoginProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Login {
}
public extension ServerPacketMojangJavaLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Login.self
        }
    }
}
public extension ServerPacketMojangJavaLoginProtocol {
    var category : Category {
        return Category.server_login
    }
}

// MARK: ServerPacketMojangJavaConfigurationProtocol
public protocol ServerPacketMojangJavaConfigurationProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Configuration {
}
public extension ServerPacketMojangJavaConfigurationProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Configuration.self
        }
    }
}
public extension ServerPacketMojangJavaConfigurationProtocol {
    var category : Category {
        return Category.server_configuration
    }
}

// MARK: ServerPacketMojangJavaPlayProtocol
public protocol ServerPacketMojangJavaPlayProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Play {
}
public extension ServerPacketMojangJavaPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Play.self
        }
    }
}
public extension ServerPacketMojangJavaPlayProtocol {
    var category : Category {
        return Category.server_play
    }
}

// MARK: ServerPacketMojangJavaStatusProtocol
public protocol ServerPacketMojangJavaStatusProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Status {
}
public extension ServerPacketMojangJavaStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Status.self
        }
    }
}
public extension ServerPacketMojangJavaStatusProtocol {
    var category : Category {
        return Category.server_status
    }
}
