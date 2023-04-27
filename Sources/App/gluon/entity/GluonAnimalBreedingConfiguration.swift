//
//  GluonAnimalBreedingConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/26/23.
//

import Foundation

struct GluonAnimalBreedingConfiguration : AnimalBreedingConfiguration {
    typealias TargetItemStack = GluonItemStack
    
    let identifier:String
    let breed_item:TargetItemStack
}
