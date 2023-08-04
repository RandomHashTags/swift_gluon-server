//
//  CPMPUpdateTags.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct UpdateTags : ClientPacketMojangPlayProtocol { // TODO: fix
        /// Number of elements in `tags`.
        public let tags_count:Int
        public let tags:[UpdateTag]
        
        public struct UpdateTag : Hashable, Codable {
            public let identifiers:[String]
            /// Number of elements in `entries`.
            public let counts:[Int]
            /// Numeric ID of the given type (block, item, etc.).
            public let entries:[Int]
        }
        public struct Tag : Hashable, Codable {
            public let length:Int
            public let tag_name:String // TODO: make Identifier
            public let count:Int
            public let entries:[Int]
        }
    }
}
