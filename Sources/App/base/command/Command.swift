//
//  Command.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Command : Hashable, Identifiable where ID == String {
    var label : LocalizedStringResource { get }
    var description : LocalizedStringResource { get }
    var aliases : Set<LocalizedStringResource> { get }
    var permission : any Permission { get }
    var permission_message : LocalizedStringResource { get }
}
