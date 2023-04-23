//
//  ProjectileSource.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class ProjectileSource {
    public let block:(any Block)?
    public let entity:(any Entity)?
    
    public init(block: (any Block)?, entity: (any Entity)?) {
        self.block = block
        self.entity = entity
    }
}
