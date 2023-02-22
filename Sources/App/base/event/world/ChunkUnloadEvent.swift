//
//  ChunkUnloadEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class ChunkUnloadEvent : ChunkEvent {
    public init(chunk: Chunk) {
        super.init(type: EventType.chunk_unload, chunk: chunk)
    }
}
