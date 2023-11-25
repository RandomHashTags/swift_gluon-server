//
//  Nameable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Nameable {
    var name : String { get }
    var custom_name : String? { get set }
}
