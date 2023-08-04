//
//  CPMPChunkBiomes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct ChunkBiomes : ClientPacketMojangPlayProtocol {
        /// Number of elements in `data`.
        public let number_of_chunks:Int
        public let data:[ChunkBiomes.BiomeData]
        
        public struct BiomeData : Hashable, Codable {
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let x:Int
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let z:Int
            /// Size of `data` in bytes
            public let size:Int
            /// Chunk data structure, with sections containing only the `Biomes` field
            public let data:Data
        }
    }
}
