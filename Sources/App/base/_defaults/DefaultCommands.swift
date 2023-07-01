//
//  DefaultCommands.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public enum DefaultCommands : String, CaseIterable, Command {
    case advancement
    case attribute
    case execute
    case bossbar
    case clear
    case clone
    case damage
    case data
    case datapack
    case debug
    case defaultgamemode
    case difficulty
    case effect
    case me
    case enchant
    case experience
    case fill
    case fillbiome
    case forceload
    case function
    case gamemode
    case gamerule
    case give
    case help
    case item
    case kick
    case kill
    case list
    case locate
    case loot
    case msg
    case particle
    case playsound
    case reload
    case recipe
    case `return`
    case ride
    case say
    case schedule
    case scoreboard
    case seed
    case setblock
    case spawnpoint
    case setworldspawn
    case spectate
    case spreadplayers
    case stopsound
    case summon
    case tag
    case team
    case teammsg
    case teleport
    case tellraw
    case time
    case title
    case trigger
    case weather
    case worldborder
    case publish
    
    public var id : String {
        return "minecraft." + rawValue
    }
    
    public var label : String {
        return get_localized_string(key: rawValue, table: "Commands").lowercased()
    }
    public var description: String {
        return get_localized_string(key: rawValue + "_description", table: "Commands")
    }
    public var aliases : Set<String> {
        switch self {
        case .experience:
            return ["xp"]
        case .msg:
            return ["tell", "w"]
        case .teammsg:
            return ["tm"]
        case .teleport:
            return ["tp"]
        default:
            return []
        }
    }
    
    public var permission : any Permission {
        switch self {
        case .advancement:     return DefaultPermissions.advancement
        case .attribute:       return DefaultPermissions.attribute
        case .execute:         return DefaultPermissions.execute
        case .bossbar:         return DefaultPermissions.bossbar
        case .clear:           return DefaultPermissions.clear
        case .clone:           return DefaultPermissions.clone
        case .damage:          return DefaultPermissions.damage
        case .data:            return DefaultPermissions.data
        case .datapack:        return DefaultPermissions.datapack
        case .debug:           return DefaultPermissions.debug
        case .defaultgamemode: return DefaultPermissions.defaultgamemode
        case .difficulty:      return DefaultPermissions.difficulty
        case .effect:          return DefaultPermissions.effect
        case .me:              return DefaultPermissions.me
        case .enchant:         return DefaultPermissions.enchant
        case .experience:      return DefaultPermissions.experience
        case .fill:            return DefaultPermissions.fill
        case .fillbiome:       return DefaultPermissions.fillbiome
        case .forceload:       return DefaultPermissions.forceload
        case .function:        return DefaultPermissions.function
        case .gamemode:        return DefaultPermissions.gamemode
        case .gamerule:        return DefaultPermissions.gamerule
        case .give:            return DefaultPermissions.give
        case .help:            return DefaultPermissions.help
        case .item:            return DefaultPermissions.item
        case .kick:            return DefaultPermissions.kick
        case .kill:            return DefaultPermissions.kill
        case .list:            return DefaultPermissions.list
        case .locate:          return DefaultPermissions.locate
        case .loot:            return DefaultPermissions.loot
        case .msg:             return DefaultPermissions.msg
        case .particle:        return DefaultPermissions.particle
        case .playsound:       return DefaultPermissions.playsound
        case .reload:          return DefaultPermissions.reload
        case .recipe:          return DefaultPermissions.recipe
        case .return:          return DefaultPermissions.return
        case .ride:            return DefaultPermissions.ride
        case .say:             return DefaultPermissions.say
        case .schedule:        return DefaultPermissions.schedule
        case .scoreboard:      return DefaultPermissions.scoreboard
        case .seed:            return DefaultPermissions.seed
        case .setblock:        return DefaultPermissions.setblock
        case .spawnpoint:      return DefaultPermissions.spawnpoint
        case .setworldspawn:   return DefaultPermissions.setworldspawn
        case .spectate:        return DefaultPermissions.spectate
        case .spreadplayers:   return DefaultPermissions.spreadplayers
        case .stopsound:       return DefaultPermissions.stopsound
        case .summon:          return DefaultPermissions.summon
        case .tag:             return DefaultPermissions.tag
        case .team:            return DefaultPermissions.team
        case .teammsg:         return DefaultPermissions.teammsg
        case .teleport:        return DefaultPermissions.teleport
        case .tellraw:         return DefaultPermissions.tellraw
        case .time:            return DefaultPermissions.time
        case .title:           return DefaultPermissions.title
        case .trigger:         return DefaultPermissions.trigger
        case .weather:         return DefaultPermissions.weather
        case .worldborder:     return DefaultPermissions.worldborder
        case .publish:         return DefaultPermissions.publish
        }
    }
    public var permission_message : String {
        return "Unknown or incomplete command, see below for error\n%error%<--[HERE]"
    }
    
    public func execute(_ sender: any CommandSender) {
        if let permissible:any Permissible = sender as? (any Permissible), !permissible.has_permission(permission.id) {
            return
        }
    }
    public func get_options(_ sender: any CommandSender, index: Int) -> [String] {
        if let permissible:any Permissible = sender as? (any Permissible), !permissible.has_permission(permission.id) {
            return []
        }
        return []
    }
}

public enum DefaultPermissions : String, CaseIterable, Permission {
    case advancement
    case attribute
    case execute
    case bossbar
    case clear
    case clone
    case damage
    case data
    case datapack
    case debug
    case defaultgamemode
    case difficulty
    case effect
    case me
    case enchant
    case experience
    case fill
    case fillbiome
    case forceload
    case function
    case gamemode
    case gamerule
    case give
    case help
    case item
    case kick
    case kill
    case list
    case locate
    case loot
    case msg
    case particle
    case playsound
    case reload
    case recipe
    case `return`
    case ride
    case say
    case schedule
    case scoreboard
    case seed
    case setblock
    case spawnpoint
    case setworldspawn
    case spectate
    case spreadplayers
    case stopsound
    case summon
    case tag
    case team
    case teammsg
    case teleport
    case tellraw
    case time
    case title
    case trigger
    case weather
    case worldborder
    case publish
    
    public var id : String {
        return "minecraft." + rawValue
    }
    public var children : Set<String> {
        return []
    }
    public var default_value : any PermissionDefaultValue {
        switch self {
        case .help,
                .list,
                .me,
                .msg,
                .seed,
                .teammsg,
                .trigger:
            return DefaultPermissionValues.true
        default:
            return DefaultPermissionValues.op
        }
    }
}

public enum DefaultPermissionValues : String, CaseIterable, PermissionDefaultValue {
    case `true`
    case `false`
    case op
    case not_op
    
    public var id : String {
        return rawValue
    }
}
