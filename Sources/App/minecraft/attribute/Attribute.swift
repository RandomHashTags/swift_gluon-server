//
//  Attribute.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Attribute : MultilingualName, Identifiable where ID == String {
    var base_value : Double { get set }
    var description : String { get }
}
