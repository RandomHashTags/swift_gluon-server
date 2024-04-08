//
//  CollectionExtensions.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public extension Collection {
    func get(_ index: Self.Index) -> Element? {
        return index < endIndex && index >= startIndex ? self[index] : nil
    }
}

internal extension Array {
    func map_set<T>(_ transform: (Element) throws -> T) rethrows -> Set<T> {
        return try map(transform).as_set
    }
}
internal extension Array where Element : Hashable {
    var as_set : Set<Element> {
        return Set<Element>(self)
    }
}

internal extension Set {
    mutating func remove(contentsOf set: Set<Element>) {
        for element in set {
            remove(element)
        }
    }
}
