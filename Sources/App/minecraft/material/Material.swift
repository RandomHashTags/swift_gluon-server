//
//  Material.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Material : MultilingualName, Hashable, Identifiable where ID == String {
    var categories : [any MaterialCategory] { get }
    var configuration : any MaterialConfiguration { get }
    /// The ``Recipe`` identifier this material can be crafted by, if applicable.
    var recipe_id : String? { get }
    /// The ``Recipe`` this material can be crafted by, if applicable.
    var recipe : (any Recipe)? { get }
}

public extension Material {
    static func == (left: any Material, right: any Material) -> Bool {
        return left.id.elementsEqual(right.id)
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
