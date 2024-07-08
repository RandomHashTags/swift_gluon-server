//
//  CPMPUpdateTags.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct UpdateTags : ClientPacket.Mojang.Java.PlayProtocol { // TODO: fix
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_tags
        
        /// Number of elements in `tags`.
        public let count:VariableIntegerJava
        public let tagTypes:[Namespace]
        public let tags:[UpdateTags.Tag]
        
        public struct Tag : Codable, PacketEncodableMojangJava {
            public let length:VariableIntegerJava
            public let entries:[UpdateTags.Tag.Entry]
            
            public struct Entry : Codable, PacketEncodableMojangJava {
                public let tagName:Namespace
                public let count:VariableIntegerJava
                /// Numeric ID of the given type (block, item, etc.).
                public let entries:[VariableIntegerJava]
                
                public func packet_bytes() throws -> [UInt8] {
                    var array:[UInt8] = try tagName.packet_bytes()
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
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [count]
            array.append(contentsOf: tagTypes)
            array.append(contentsOf: tags)
            return array
        }
    }
}
