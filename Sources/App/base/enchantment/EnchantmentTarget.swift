//
//  EnchantmentTarget.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol EnchantmentTarget : Hashable {
    var material_ids : Set<String> { get }
    var materials : [any Material] { get }
}
