//
//  NBTGossip.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTGossip : NBTTag {
    var value : Int { get }
    var target : UUID { get }
    var type : String { get }
}