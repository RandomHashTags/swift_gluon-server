//
//  ChunkLoadEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class ChunkLoadEvent : ChunkEvent {
    public let type:EventType, chunk:Chunk
    
    public init(chunk: Chunk) {
        type = EventType.chunk_load
        self.chunk = chunk
    }
    
    public func get_context(key: String) -> ExecutableLogicalContext? {
        return nil
    }
}
