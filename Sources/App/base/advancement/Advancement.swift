//
//  Advancement.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Advancement : MultilingualName, Identifiable where ID == String {
    var description : LocalizedStringResource { get }
    var criteria : [String] { get }
}
