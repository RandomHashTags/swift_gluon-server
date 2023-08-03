//
//  CPMPUpdateTags.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct UpdateTags : ClientPacketMojangProtocol { // TODO: fix
        /// Number of elements in `tags`.
        let tags_count:Int
        let tags:[UpdateTag]
        
        struct UpdateTag : Hashable, Codable {
            let identifiers:[String]
            /// Number of elements in `entries`.
            let counts:[Int]
            /// Numeric ID of the given type (block, item, etc.).
            let entries:[Int]
        }
        struct Tag : Hashable, Codable {
            let length:Int
            let tag_name:String // TODO: make Identifier
            let count:Int
            let entries:[Int]
        }
    }
}
