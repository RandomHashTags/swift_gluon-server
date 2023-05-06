//
//  GluonChunkLoadEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonChunkLoadEvent : ChunkLoadEvent {
    typealias TargetEventType = GluonEventType
    
    let type:TargetEventType = GluonEventType.chunk_load
    var chunk:any Chunk
    var is_cancelled:Bool = false
    
    init(chunk: any Chunk) {
        self.chunk = chunk
    }
}
