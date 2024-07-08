//
//  PlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public protocol PlayerItemConsumeEvent : PlayerEvent, Cancellable {
    var item : ItemStack { get set }
    
    init(player: any Player, item: inout ItemStack)
}
