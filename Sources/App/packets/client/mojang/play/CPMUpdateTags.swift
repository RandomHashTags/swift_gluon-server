//
//  CPMUpdateTags.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang {
    struct UpdateTags : ClientPacketMojangProtocol {
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
    }
}
