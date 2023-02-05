//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Chunk : Jsonable {
    public let world:World
    public let x:Int64
    public let z:Int64

    public func load() async {
    }
    public func unload() {
    }
}
