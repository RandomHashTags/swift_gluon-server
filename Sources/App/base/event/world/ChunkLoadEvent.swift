//
//  ChunkLoadEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol ChunkLoadEvent : ChunkEvent {
    var context : [String:ExecutableLogicalContext]? { get }
}
