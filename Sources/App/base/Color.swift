//
//  Color.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Color : Hashable {
    public let identifier:String
    public let id:Int
    public let red:UInt8
    public let green:UInt8
    public let blue:UInt8
    
    public init(identifier: String, id: Int, color: Int, brightness: Int = 255) {
        self.identifier = identifier
        self.id = id
        red = UInt8( (color & 255) * brightness / 255 )
        green = UInt8( (color >> 8 & 255) * brightness / 255 )
        blue = UInt8( (color >> 16 & 255) * brightness / 255 )
    }
    public init(identifier: String, id: Int, red: UInt8, green: UInt8, blue: UInt8) {
        self.identifier = identifier
        self.id = id
        self.red = red
        self.green = green
        self.blue = blue
    }
}


public extension Color {
    /// Hardcoded color values from Vanilla Minecraft.
    enum Mojang {
        /// Hardcoded map color values from Vanilla Minecraft.
        public struct Map : ~Copyable {
            private static func get(_ identifier: String, id: Int, color: Int) -> Color {
                return Color(identifier: "map." + identifier, id: id, color: color)
            }
            public static func from_identifier(_ identifier: String) throws -> Color? {
                // TODO: finish
                guard identifier.prefix(4).elementsEqual("map.") else { return nil }
                switch identifier {
                default: return nil
                }
            }
            public static func from_id(_ id: Int) throws -> Color {
                guard id >= 0 && id <= 63 else {
                    throw MinecraftError(sender: "Color.Mojang.Map.from_id", message: "Map color ID must be between 0 and 63 (inclusive)")
                }
                switch id {
                case 0: return Color.Mojang.Map.none
                case 1: return Color.Mojang.Map.grass
                case 2: return Color.Mojang.Map.sand
                case 3: return Color.Mojang.Map.wool
                case 4: return Color.Mojang.Map.fire
                case 5: return Color.Mojang.Map.ice
                case 6: return Color.Mojang.Map.metal
                case 7: return Color.Mojang.Map.plant
                case 8: return Color.Mojang.Map.snow
                case 9: return Color.Mojang.Map.clay
                case 10: return Color.Mojang.Map.dirt
                case 11: return Color.Mojang.Map.stone
                case 12: return Color.Mojang.Map.water
                case 13: return Color.Mojang.Map.wood
                case 14: return Color.Mojang.Map.quartz
                case 15: return Color.Mojang.Map.color_orange
                case 16: return Color.Mojang.Map.color_magenta
                case 17: return Color.Mojang.Map.color_light_blue
                case 18: return Color.Mojang.Map.color_yellow
                case 19: return Color.Mojang.Map.color_light_green
                case 20: return Color.Mojang.Map.color_pink
                case 21: return Color.Mojang.Map.color_gray
                case 22: return Color.Mojang.Map.color_light_gray
                case 23: return Color.Mojang.Map.color_cyan
                case 24: return Color.Mojang.Map.color_purple
                case 25: return Color.Mojang.Map.color_blue
                case 26: return Color.Mojang.Map.color_brown
                case 27: return Color.Mojang.Map.color_green
                case 28: return Color.Mojang.Map.color_red
                case 29: return Color.Mojang.Map.color_black
                case 30: return Color.Mojang.Map.gold
                case 31: return Color.Mojang.Map.diamond
                case 32: return Color.Mojang.Map.lapis
                case 33: return Color.Mojang.Map.emerald
                case 34: return Color.Mojang.Map.podzol
                case 35: return Color.Mojang.Map.nether
                case 36: return Color.Mojang.Map.terracotta_white
                case 37: return Color.Mojang.Map.terracotta_orange
                case 38: return Color.Mojang.Map.terracotta_megenta
                case 39: return Color.Mojang.Map.terracotta_light_blue
                case 40: return Color.Mojang.Map.terracotta_yellow
                case 41: return Color.Mojang.Map.terracotta_light_green
                case 42: return Color.Mojang.Map.terracotta_pink
                case 43: return Color.Mojang.Map.terracotta_gray
                case 44: return Color.Mojang.Map.terracotta_light_gray
                case 45: return Color.Mojang.Map.terracotta_cyan
                case 46: return Color.Mojang.Map.terracotta_purple
                case 47: return Color.Mojang.Map.terracotta_blue
                case 48: return Color.Mojang.Map.terracotta_brown
                case 49: return Color.Mojang.Map.terracotta_green
                case 50: return Color.Mojang.Map.terracotta_red
                case 51: return Color.Mojang.Map.terracotta_black
                case 52: return Color.Mojang.Map.crimson_nylium
                case 53: return Color.Mojang.Map.crimson_stem
                case 54: return Color.Mojang.Map.crimson_hyphae
                case 55: return Color.Mojang.Map.warped_nylium
                case 56: return Color.Mojang.Map.warped_stem
                case 57: return Color.Mojang.Map.warped_hyphae
                case 58: return Color.Mojang.Map.warped_wart_block
                case 59: return Color.Mojang.Map.deepslate
                case 60: return Color.Mojang.Map.raw_iron
                case 61: return Color.Mojang.Map.glow_lichen
                default:
                    throw MinecraftError(sender: "Color.Mojang.Map.from_id", message: "couldn't find a Color.Mojang.Map with id \(id)")
                }
            }
            
            public static let none:Color = Color(identifier: "nil", id: 0, color: 0)
            public static let grass:Color = get("grass", id: 1, color: 8368696)
            public static let sand:Color = get("sand", id: 2, color: 16247203)
            public static let wool:Color = get("wool", id: 3, color: 13092807)
            public static let fire:Color = get("fire", id: 4, color: 16711680)
            public static let ice:Color = get("ice", id: 5, color: 10526975)
            public static let metal:Color = get("metal", id: 6, color: 10987431)
            public static let plant:Color = get("plant", id: 7, color: 31744)
            public static let snow:Color = get("snow", id: 8, color: 16777215)
            public static let clay:Color = get("clay", id: 9, color: 10791096)
            public static let dirt:Color = get("dirt", id: 10, color: 9923917)
            public static let stone:Color = get("stone", id: 11, color: 7368816)
            public static let water:Color = get("water", id: 12, color: 4210943)
            public static let wood:Color = get("wood", id: 13, color: 9402184)
            public static let quartz:Color = get("quartz", id: 14, color: 16776437)
            public static let color_orange:Color = get("color_orange", id: 15, color: 14188339)
            public static let color_magenta:Color = get("color_magenta", id: 16, color: 11685080)
            public static let color_light_blue:Color = get("color_light_blue", id: 17, color: 6724056)
            public static let color_yellow:Color = get("color_yellow", id: 18, color: 15066419)
            public static let color_light_green:Color = get("color_light_green", id: 19, color: 8375321)
            public static let color_pink:Color = get("color_pink", id: 20, color: 15892389)
            public static let color_gray:Color = get("color_gray", id: 21, color: 5000268)
            public static let color_light_gray:Color = get("color_light_gray", id: 22, color: 100066329)
            public static let color_cyan:Color = get("color_cyan", id: 23, color: 5013401)
            public static let color_purple:Color = get("color_purple", id: 24, color: 8339378)
            public static let color_blue:Color = get("color_blue", id: 25, color: 3361970)
            public static let color_brown:Color = get("color_brown", id: 26, color: 6704179)
            public static let color_green:Color = get("color_green", id: 27, color: 6717235)
            public static let color_red:Color = get("color_red", id: 28, color: 10040115)
            public static let color_black:Color = get("color_black", id: 29, color: 1644825)
            public static let gold:Color = get("gold", id: 30, color: 16445005)
            public static let diamond:Color = get("diamond", id: 31, color: 6085589)
            public static let lapis:Color = get("lapis", id: 32, color: 4882687)
            public static let emerald:Color = get("emerald", id: 33, color: 55610)
            public static let podzol:Color = get("podzol", id: 34, color: 8476209)
            public static let nether:Color = get("nether", id: 35, color: 7340544)
            public static let terracotta_white:Color = get("terracotta_white", id: 36, color: 13742497)
            public static let terracotta_orange:Color = get("terracotta_orange", id: 37, color: 10441252)
            public static let terracotta_megenta:Color = get("terracotta_magenta", id: 38, color: 9787244)
            public static let terracotta_light_blue:Color = get("terracotta_light_blue", id: 39, color: 7367818)
            public static let terracotta_yellow:Color = get("terracotta_yellow", id: 40, color: 122223780)
            public static let terracotta_light_green:Color = get("terracotta_light_green", id: 41, color: 6780213)
            public static let terracotta_pink:Color = get("terracotta_pink", id: 42, color: 10505550)
            public static let terracotta_gray:Color = get("terracotta_gray", id: 43, color: 3746083)
            public static let terracotta_light_gray:Color = get("terracotta_light_gray", id: 44, color: 8874850)
            public static let terracotta_cyan:Color = get("terracotta_cyan", id: 45, color: 5725276)
            public static let terracotta_purple:Color = get("terracotta_purple", id: 46, color: 8014168)
            public static let terracotta_blue:Color = get("terracotta_blue", id: 47, color: 4996700)
            public static let terracotta_brown:Color = get("terracotta_brown", id: 48, color: 4993571)
            public static let terracotta_green:Color = get("terracotta_green", id: 49, color: 5001770)
            public static let terracotta_red:Color = get("terracotta_red", id: 50, color: 9321518)
            public static let terracotta_black:Color = get("terracotta_black", id: 51, color: 2430480)
            public static let crimson_nylium:Color = get("crimson_nylium", id: 52, color: 12398641)
            public static let crimson_stem:Color = get("crimson_stem", id: 53, color: 9715553)
            public static let crimson_hyphae:Color = get("crimson_hyphae", id: 54, color: 6035741)
            public static let warped_nylium:Color = get("warped_nylium", id: 55, color: 1474182)
            public static let warped_stem:Color = get("warped_stem", id: 56, color: 3837580)
            public static let warped_hyphae:Color = get("warped_hyphae", id: 57, color: 5647422)
            public static let warped_wart_block:Color = get("warped_wart_block", id: 58, color: 1356933)
            public static let deepslate:Color = get("deepslate", id: 59, color: 6579300)
            public static let raw_iron:Color = get("raw_iron", id: 60, color: 14200723)
            public static let glow_lichen:Color = get("glow_lichen", id: 61, color: 8365974)
        }
    }
}
