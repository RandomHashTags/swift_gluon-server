//
//  Sound.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Sound : Identifiable, MultilingualName {
    public let id:String
    
    public let categoryID:String
    public let name:LocalizedStringResource
}
