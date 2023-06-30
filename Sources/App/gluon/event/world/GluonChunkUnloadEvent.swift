//
//  GluonChunkUnloadEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonChunkUnloadEvent : ChunkUnloadEvent {
    let type:any EventType = GluonEventType.chunk_unload
    var chunk:any Chunk
    var is_cancelled:Bool = false
    
    init(chunk: any Chunk) {
        self.chunk = chunk
    }
}
