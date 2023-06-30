//
//  LocalizationExtensions.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

extension LocalizedStringResource : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(table)
        hasher.combine(locale)
    }
}
