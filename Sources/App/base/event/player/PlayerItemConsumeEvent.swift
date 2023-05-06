//
//  PlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public protocol PlayerItemConsumeEvent : PlayerEvent, Cancellable {
    associatedtype TargetItemStack : ItemStack
    
    var item : TargetItemStack { get set }
    
    init(player: any Player, item: inout TargetItemStack)
}
