//
//  MaterialCategory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialCategory : Jsonable, Identifiable {
    associatedtype TargetMaterialConfiguration : MaterialConfiguration
    
    var configuration : TargetMaterialConfiguration { get }
}
