//
//  Nameable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Nameable : Jsonable {
    var custom_name : String? { get set }
}
