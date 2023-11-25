//
//  CollectionExtensions.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

internal extension Array {
    func get(_ index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
    
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
