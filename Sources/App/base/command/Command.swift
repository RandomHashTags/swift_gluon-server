//
//  Command.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Command : Jsonable {
    public let identifier:String
    public let slug:String
    public let description:MultilingualStrings
    public let aliases:Set<String>
}
