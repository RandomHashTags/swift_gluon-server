//
//  MultilingualStrings.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public struct MultilingualStrings : Jsonable {
    public let english:String
    
    public let spanish:String?
    
    public let french:String?
    
    public init(english: String, spanish: String? = nil, french: String? = nil) {
        self.english = english
        self.spanish = spanish
        self.french = french
    }
}
