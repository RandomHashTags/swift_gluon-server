//
//  ChunkLoadEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class ChunkLoadEvent : ChunkEvent {
    public let type:EventType, chunk:any Chunk
    public let context:[String:ExecutableLogicalContext]? = nil
    
    public init(chunk: any Chunk) {
        type = EventType.chunk_load
        self.chunk = chunk
    }
}
