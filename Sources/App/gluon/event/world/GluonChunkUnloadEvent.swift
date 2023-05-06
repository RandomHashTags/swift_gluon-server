//
//  GluonChunkUnloadEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonChunkUnloadEvent : ChunkUnloadEvent {
    typealias TargetEventType = GluonEventType
    
    let type:TargetEventType = GluonEventType.chunk_unload
    var chunk:any Chunk
    var is_cancelled:Bool = false
    
    init(chunk: any Chunk) {
        self.chunk = chunk
    }
}
