//
//  BossBar.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol BossBar {
    var title : String { get set }
    var progress : Double { get set }
    var color : Color { get set }
}
