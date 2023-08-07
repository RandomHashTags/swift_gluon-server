//
//  CommandNodeMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public struct CommandNodeMojang : Hashable, Codable, PacketEncodableMojang {
    let flags:Int
    let children_count:VariableInteger
    let children:[VariableInteger]
    let redirect_node:VariableInteger?
    let name:String?
    let parser_id:VariableInteger?
    let properties:Data?
    let suggestions_type:Namespace?
    
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = [UInt8(flags)]
        array.append(contentsOf: try children_count.packet_bytes())
        for child in children {
            array.append(contentsOf: try child.packet_bytes())
        }
        if flags & 0x08 != 0 {
            guard let redirect_node:VariableInteger = redirect_node else {
                throw GeneralPacketError.command_node_missing_redirect_node
            }
            array.append(contentsOf: try redirect_node.packet_bytes())
        }
        return array
    }
}
