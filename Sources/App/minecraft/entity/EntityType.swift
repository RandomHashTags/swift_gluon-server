//
//  EntityType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs

public struct EntityType : Identifiable, MultilingualName, ServerTickChangeListener {
    public let id:String
    public let name:LocalizedStringResource

    public let isAffectedByGravity:Bool
    public let isDamageable:Bool

    public let receivesFallDamage:Bool

    public var noDamageTicksMaximum:UInt16
    public var fireTicksMaximum:UInt16
    public var freezeTicksMaximum:UInt16

    public mutating func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        noDamageTicksMaximum /= divisor
        fireTicksMaximum /= divisor
        freezeTicksMaximum /= divisor
    }
    public mutating func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        noDamageTicksMaximum *= multiplier
        fireTicksMaximum *= multiplier
        freezeTicksMaximum *= multiplier
    }
}