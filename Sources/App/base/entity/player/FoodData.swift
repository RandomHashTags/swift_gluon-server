//
//  FoodData.swift
//
//
//  Created by Evan Anderson on 11/18/23.
//

import Foundation

public protocol FoodData : Tickable {
    var food_level : Int { get set }
    var saturation_level : Float { get set }
    var exhaustion_level : Float { get set }
}
