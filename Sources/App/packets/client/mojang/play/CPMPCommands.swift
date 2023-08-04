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
        /// Number of elements in `nodes`.
        public let count:Int
        public let nodes:[CommandNodeMojang]
        /// Index of the `root` node in `nodes`.
        public let root_index:Int
    }
}
