//
//  CommandNodeMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public struct CommandNodeMojang : Hashable, Codable {
    let flags:Int
    let children_count:Int
    let children:[Int]
    let redirect_node:Int?
    let name:String?
    let parser_id:Int?
    let properties:Data?
    let suggestions_type:String? // TODO: make `Identifier`
}
