//
//  Material.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Material : Jsonable {
    public let identifier:String
    public let categories:[MaterialCategory]
    public let configuration:MaterialConfiguration
}
