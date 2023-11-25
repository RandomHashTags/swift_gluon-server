//
//  Permissible.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol Permissible : Hashable {
    var permissions : Set<String> { get set }
}

public extension Permissible {
    func has_permission(_ permission: String) -> Bool {
        return permissions.contains(permission)
    }
}
