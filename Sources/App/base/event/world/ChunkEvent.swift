//
//  ChunkEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class ChunkEvent : WorldEvent {
    public let chunk:Chunk
    
    public init(type: EventType, chunk: Chunk) {
        self.chunk = chunk
        super.init(type: type, world: chunk.world)
    }
}
