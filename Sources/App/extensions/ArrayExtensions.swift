//
//  ArrayExtensions.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

internal extension Array {
    func get(_ index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
}
