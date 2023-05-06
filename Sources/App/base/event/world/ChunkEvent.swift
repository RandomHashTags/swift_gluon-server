//
//  ChunkEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol ChunkEvent : Event {
    var chunk : any Chunk { get }
}
public extension ChunkEvent {
    var context : [String:ExecutableLogicalContext]? {
        return nil
    }
}
