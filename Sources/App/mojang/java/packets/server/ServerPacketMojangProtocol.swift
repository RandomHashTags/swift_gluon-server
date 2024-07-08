//
//  ServerPacketMojangJavaProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

protocol ServerPacketMojangJavaProtocol : ServerPacketProtocol, PacketMojangJava {
}

// MARK: ServerPacketMojangJavaHandshakingProtocol
protocol ServerPacketMojangJavaHandshakingProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Handshaking {
}
extension ServerPacketMojangJavaHandshakingProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Handshaking.self
        }
    }
}
extension ServerPacketMojangJavaHandshakingProtocol {
    var category : Category {
        return Category.server_handshaking
    }
}

// MARK: ServerPacketMojangJavaLoginProtocol
protocol ServerPacketMojangJavaLoginProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Login {
}
extension ServerPacketMojangJavaLoginProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Login.self
        }
    }
}
extension ServerPacketMojangJavaLoginProtocol {
    var category : Category {
        return Category.server_login
    }
}

// MARK: ServerPacketMojangJavaConfigurationProtocol
protocol ServerPacketMojangJavaConfigurationProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Configuration {
}
extension ServerPacketMojangJavaConfigurationProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Configuration.self
        }
    }
}
extension ServerPacketMojangJavaConfigurationProtocol {
    var category : Category {
        return Category.server_configuration
    }
}

// MARK: ServerPacketMojangJavaPlayProtocol
protocol ServerPacketMojangJavaPlayProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Play {
}
extension ServerPacketMojangJavaPlayProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Play.self
        }
    }
}
extension ServerPacketMojangJavaPlayProtocol {
    var category : Category {
        return Category.server_play
    }
}

// MARK: ServerPacketMojangJavaStatusProtocol
protocol ServerPacketMojangJavaStatusProtocol : ServerPacketMojangJavaProtocol where GameplayID == ServerPacket.Mojang.Java.Status {
}
extension ServerPacketMojangJavaStatusProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ServerPacket.Mojang.Java.Status.self
        }
    }
}
extension ServerPacketMojangJavaStatusProtocol {
    var category : Category {
        return Category.server_status
    }
}
