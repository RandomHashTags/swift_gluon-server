//
//  ClientPacketMojangJavaProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

protocol ClientPacketMojangJavaProtocol : ClientPacketProtocol, PacketMojangJava {
}

// MARK: ClientPacketMojangJavaStatusProtocol
protocol ClientPacketMojangJavaStatusProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Status {
}
extension ClientPacketMojangJavaStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Status.self
        }
    }
}
extension ClientPacketMojangJavaStatusProtocol {
    var category : Category {
        return Category.client_handshaking
    }
}

// MARK: ClientPacketMojangJavaLoginProtocol
protocol ClientPacketMojangJavaLoginProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Login {
}
extension ClientPacketMojangJavaLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Login.self
        }
    }
}
extension ClientPacketMojangJavaLoginProtocol {
    var category : Category {
        return Category.client_login
    }
}

// MARK: ClientPacketMojangJavaConfigurationProtocol
protocol ClientPacketMojangJavaConfigurationProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Configuration {
}
extension ClientPacketMojangJavaConfigurationProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Configuration.self
        }
    }
}
extension ClientPacketMojangJavaConfigurationProtocol {
    var category : Category {
        return Category.client_configuration
    }
}

// MARK: ClientPacketMojangJavaPlayProtocol
protocol ClientPacketMojangJavaPlayProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Play {
}
extension ClientPacketMojangJavaPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Play.self
        }
    }
}
extension ClientPacketMojangJavaPlayProtocol {
    var category : Category {
        return Category.client_play
    }
}
