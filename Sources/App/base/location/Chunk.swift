//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Chunk : Jsonable, Tickable {
    public let world:World
    public let x:Int64
    public let z:Int64

    public func load() async {
        let seed:Int64 = world.seed
    }
    public func unload() {
    }
    
    func save() {
    }
    public func tick(_ server: GluonServer) {
    }
}
