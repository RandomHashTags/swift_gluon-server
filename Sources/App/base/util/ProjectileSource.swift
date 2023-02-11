//
//  ProjectileSource.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class ProjectileSource {
    public let block:Block?
    public let entity:Entity?
    
    public init(block: Block?, entity: Entity?) {
        self.block = block
        self.entity = entity
    }
}
