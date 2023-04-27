//
//  AnimalBreedingConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol AnimalBreedingConfiguration : Jsonable, Identifiable {
    associatedtype TargetItemStack : ItemStack
    
    var breed_item : TargetItemStack { get }
}
