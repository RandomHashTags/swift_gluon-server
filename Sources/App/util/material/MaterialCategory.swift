//
//  MaterialCategory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct MaterialCategory : Hashable {
    public let identifier:String
    public let configuration:UnsafePointer<MaterialConfiguration>
}
