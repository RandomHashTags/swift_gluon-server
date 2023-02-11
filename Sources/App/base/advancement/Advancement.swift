//
//  Advancement.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Advancement : Jsonable {
    public let identifier:String
    public let name:String, description:String
    public let criteria:[String]
}
