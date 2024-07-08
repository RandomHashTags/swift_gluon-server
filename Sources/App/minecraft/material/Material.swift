//
//  Material.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs

public struct Material : Identifiable, Hashable, MultilingualName {
    public static func == (left: Self, right: Self) -> Bool {
        return left.id == right.id
    }

    public let id:String
    public let name:LocalizedStringResource
    /// The ``Recipe`` id this material can be crafted by, if applicable.
    public let recipeID:String?

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/*
public protocol Material : MultilingualName, Hashable, Identifiable where ID == String {
    var categories : [any MaterialCategory] { get }
    var configuration : any MaterialConfiguration { get }
    
    var recipeID : String? { get }
    /// The ``Recipe`` this material can be crafted by, if applicable.
    var recipe : (any Recipe)? { get }
}*/