//
//  CPMPDisconnect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Sent by the server before it disconnects a client. The client assumes that the server has already closed the connection by the time the packet arrives.
    struct Disconnect : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.disconnect
        
        /// Displayed to the client when the connection terminates.
        public let reason:ChatPacketMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [reason]
        }
    }
}
