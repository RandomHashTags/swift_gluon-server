//
//  MaterialItemConsumableConfiguration.swift
//  
//
//  Created by Evan Anderson on 3/5/23.
//

import Foundation

public protocol MaterialItemConsumableConfiguration : Identifiable where ID == String {
    /// Amount of ticks required of consuming to consider this item to be consumed.
    var duration : UInt64 { get set }
    /// The logic executed when this item is considered consumed.
    var executable_logic : [ExecutableLogic] { get }
}
