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
    static var packetGameplayID : GameplayID.Type {
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
    static var packetGameplayID : GameplayID.Type {
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

// MARK: ClientPacket.Mojang.Java.ConfigurationProtocol
extension ClientPacket.Mojang.Java {
    protocol ConfigurationProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Configuration {
    }
}
extension ClientPacket.Mojang.Java.ConfigurationProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Configuration.self
        }
    }
}
extension ClientPacket.Mojang.Java.ConfigurationProtocol {
    var category : Category {
        return Category.client_configuration
    }
}

// MARK: ClientPacket.Mojang.Java.PlayProtocol
extension ClientPacket.Mojang.Java {
    protocol PlayProtocol : ClientPacketMojangJavaProtocol where GameplayID == ClientPacket.Mojang.Java.Play {
    }
}

extension ClientPacket.Mojang.Java.PlayProtocol {
    static var packetGameplayID : GameplayID.Type {
        get {
            return ClientPacket.Mojang.Java.Play.self
        }
    }
}
extension ClientPacket.Mojang.Java.PlayProtocol {
    var category : Category {
        return Category.client_play
    }
}
