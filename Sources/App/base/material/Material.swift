//
//  Material.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Material : Jsonable {
    public let identifier:String
    public let name:MultilingualStrings
    public let categories:[MaterialCategory]
    public let configuration:MaterialConfiguration
    /// The ``Recipe`` identifier this material can be crafted by.
    public let recipe_identifier:String?
}
public extension Material {
    var recipe : Recipe? {
        return nil
    }
}
