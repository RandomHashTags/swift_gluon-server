//
//  Biome.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Biome : Identifiable where ID == String {
    var configuration : any BiomeConfiguration { get }
}
