//
//  GluonChunkLoadEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonChunkLoadEvent : ChunkLoadEvent {
    let type:any EventType = GluonEventType.chunk_load
    var chunk:any Chunk
    var isCancelled:Bool = false
    
    init(chunk: any Chunk) {
        self.chunk = chunk
    }
}
