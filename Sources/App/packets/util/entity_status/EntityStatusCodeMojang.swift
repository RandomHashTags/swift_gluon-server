//
//  EntityStatusCodeMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

// https://wiki.vg/Entity_statuses
public enum EntityStatusCodeMojang : UInt, Hashable, Codable {
    case arrow = 0
    case minecart_spawner_or_rabbit
    case none
    case egg_or_living_entity_or_snowball
    case evoker_fangs_or_hoglin_or_iron_golem_or_ravager_or_warden_or_zoglin
    case none_2
    case abstract_horse_or_tameable_animal
    case abstract_horse_or_tameable_animal_2
}
