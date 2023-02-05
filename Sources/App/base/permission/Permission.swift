//
//  Permission.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Permission : Jsonable {
    public let identifier:String
    public let description:String
    public let children:Set<String>
}
