//
//  MultilingualName.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import SwiftStringCatalogs

public protocol MultilingualName {
    var name : LocalizedStringResource { get }
}
