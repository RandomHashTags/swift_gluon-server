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
        public let number_of_chunks:VariableInteger
        public let data:[ChunkBiomes.BiomeData]
        
        public struct BiomeData : Hashable, Codable, PacketEncodableMojang {
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let x:Int
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let z:Int
            /// Size of `data` in bytes
            public let size:VariableInteger
            /// Chunk data structure, with sections containing only the `Biomes` field
            public let data:[UInt8]
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = try x.packet_bytes()
                array.append(contentsOf: try z.packet_bytes())
                array.append(contentsOf: try size.packet_bytes())
                array.append(contentsOf: data)
                return array
            }
        }
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [number_of_chunks]
            array.append(contentsOf: data)
            return array
        }
    }
}
