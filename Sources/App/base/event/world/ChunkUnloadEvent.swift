//
//  ChunkUnloadEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class ChunkUnloadEvent : ChunkEvent, Cancellable {
    public let type:EventType, chunk:Chunk
    public var is_cancelled:Bool
    public let context:[String:ExecutableLogicalContext]? = nil
    
    public init(chunk: Chunk) {
        type = EventType.chunk_unload
        self.chunk = chunk
        is_cancelled = false
    }
}
