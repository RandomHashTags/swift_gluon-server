//
//  CPMPCommands.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Lists all of the commands on the server, and how they are parsed.
    ///
    /// This is a directed graph, with one root node. Each redirect or child node must refer only to nodes that have already been declared.
    struct Commands : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.commands
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let count:VariableIntegerJava = try packet.read_var_int()
            let nodes:[CommandNodeMojang] = try packet.read_map(count: count) {
                return try packet.read_packet_decodable()
            }
            let root_index:VariableIntegerJava = try packet.read_var_int()
            return Self(count: count, nodes: nodes, root_index: root_index)
        }
        
        /// Number of elements in `nodes`.
        public let count:VariableIntegerJava
        public let nodes:[CommandNodeMojang]
        /// Index of the `root` node in `nodes`.
        public let root_index:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [count]
            array.append(contentsOf: nodes)
            array.append(root_index)
            return array
        }
    }
}
