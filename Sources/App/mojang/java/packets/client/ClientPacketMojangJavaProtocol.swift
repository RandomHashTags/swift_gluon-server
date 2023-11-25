//
//  ClientPacketMojangJavaProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ClientPacketMojangJavaProtocol : ClientPacketProtocol, PacketMojangJava {
}

// MARK: ClientPacketMojangJavaStatusProtocol
public protocol ClientPacketMojangJavaStatusProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Status {
}
public extension ClientPacketMojangJavaStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Status.self
        }
    }
}
public extension ClientPacketMojangJavaStatusProtocol {
    var category : Category {
        return Category.client_handshaking
    }
}

// MARK: ClientPacketMojangJavaLoginProtocol
public protocol ClientPacketMojangJavaLoginProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Login {
}
public extension ClientPacketMojangJavaLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Login.self
        }
    }
}
public extension ClientPacketMojangJavaLoginProtocol {
    var category : Category {
        return Category.client_login
    }
}

// MARK: ClientPacketMojangJavaConfigurationProtocol
public protocol ClientPacketMojangJavaConfigurationProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Configuration {
}
public extension ClientPacketMojangJavaConfigurationProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Configuration.self
        }
    }
}
public extension ClientPacketMojangJavaConfigurationProtocol {
    var category : Category {
        return Category.client_configuration
    }
}

// MARK: ClientPacketMojangJavaPlayProtocol
public protocol ClientPacketMojangJavaPlayProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Play {
}
public extension ClientPacketMojangJavaPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Play.self
        }
    }
}
public extension ClientPacketMojangJavaPlayProtocol {
    var category : Category {
        return Category.client_play
    }
}
