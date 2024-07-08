//
//  Advancement.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation
import SwiftStringCatalogs

public struct Advancement : Identifiable, MultilingualName {
    public let id:String
    public let name:LocalizedStringResource
    
    public let description:String
    public let criteria:[String]
    public var done:Date?
}