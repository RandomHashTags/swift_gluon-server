//
//  Sound.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Sound : MultilingualName, Identifiable where ID == String {
    var category_id : String { get }
    var category : (any SoundCategory)? { get }
}
