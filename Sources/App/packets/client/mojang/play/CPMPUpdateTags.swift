//
//  CPMPUpdateTags.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct UpdateTags : ClientPacketMojangPlayProtocol { // TODO: fix
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.update_tags
        
        /// Number of elements in `tags`.
        public let count:VariableInteger
        public let tag_types:[Namespace]
        public let tags:[UpdateTags.Tag]
        
        public struct Tag : Hashable, Codable, PacketEncodableMojang {
            public let length:VariableInteger
            public let entries:[UpdateTags.Tag.Entry]
            
            public struct Entry : Hashable, Codable, PacketEncodableMojang {
                public let tag_name:Namespace
                public let count:VariableInteger
                /// Numeric ID of the given type (block, item, etc.).
                public let entries:[VariableInteger]
                
                public func packet_bytes() throws -> [UInt8] {
                    var array:[UInt8] = try tag_name.packet_bytes()
                    array.append(contentsOf: try count.packet_bytes())
                    for entry in entries {
                        array.append(contentsOf: try entry.packet_bytes())
                    }
                    return array
                }
            }
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = try length.packet_bytes()
                for entry in entries {
                    array.append(contentsOf: try entry.packet_bytes())
                }
                return array
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [count]
            array.append(contentsOf: tag_types)
            array.append(contentsOf: tags)
            return array
        }
    }
}
