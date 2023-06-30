//
//  Permission.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Permission : Identifiable where ID == String {
    var description : LocalizedStringResource { get }
    var children : Set<String> { get }
}
