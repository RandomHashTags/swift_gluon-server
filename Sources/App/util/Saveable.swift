//
//  Saveable.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public protocol Saveable {
    /// Saves this object to disk.
    func save()
}
public extension Saveable where Self: Jsonable {
    func save() {
        do {
            let encoder:JSONEncoder = JSONEncoder()
            let data:Data = try encoder.encode(self)
            // TODO: write to disk
        } catch {
            print("Saveable;error=\(error)")
        }
    }
}
