//
//  CPMPCommands.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Lists all of the commands on the server, and how they are parsed.
    ///
    /// This is a directed graph, with one root node. Each redirect or child node must refer only to nodes that have already been declared.
    struct Commands : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let count:VariableInteger = try packet.read_var_int()
            let nodes:[CommandNodeMojang] = try packet.read_map(count: count) {
                return try packet.read_packet_decodable()
            }
            let root_index:VariableInteger = try packet.read_var_int()
            return Self(count: count, nodes: nodes, root_index: root_index)
        }
        
        /// Number of elements in `nodes`.
        public let count:VariableInteger
        public let nodes:[CommandNodeMojang]
        /// Index of the `root` node in `nodes`.
        public let root_index:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [count]
            array.append(contentsOf: nodes)
            array.append(root_index)
            return array
        }
    }
}
