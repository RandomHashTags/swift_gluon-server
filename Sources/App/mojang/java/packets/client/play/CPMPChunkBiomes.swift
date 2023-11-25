//
//  CPMPChunkBiomes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    struct ChunkBiomes : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.chunk_biomes
        
        /// Number of elements in `data`.
        public let number_of_chunks:VariableIntegerJava
        public let data:[ChunkBiomes.BiomeData]
        
        public struct BiomeData : Hashable, Codable, PacketEncodableMojangJava {
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let x:Int
            /// Chunk coordinate (block coordinate divided by 16, rounded down)
            public let z:Int
            /// Size of `data` in bytes
            public let size:VariableIntegerJava
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
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [number_of_chunks]
            array.append(contentsOf: data)
            return array
        }
    }
}
