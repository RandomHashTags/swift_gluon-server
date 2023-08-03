//
//  CPMPChunkBiomes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct ChunkBiomes : ClientPacketMojangProtocol {
        /// Number of elements in `data`.
        let number_of_chunks:Int
        let data:[ChunkBiomes.BiomeData]
        
        struct BiomeData : Hashable, Codable {
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            let x:Int
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            let z:Int
            /// Size of `data` in bytes
            let size:Int
            /// Chunk data structure, with sections containing only the `Biomes` field
            let data:Data
        }
    }
}
