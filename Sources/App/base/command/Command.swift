//
//  Command.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Command : Hashable, Identifiable where ID == String {
    var slug : LocalizedStringResource { get }
    var description : LocalizedStringResource { get }
    var aliases : Set<LocalizedStringResource> { get }
}
