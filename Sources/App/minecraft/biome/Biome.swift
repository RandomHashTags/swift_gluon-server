//
//  Biome.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct Biome : Identifiable {
    public let id:String
}

public extension Biome {
    private static func get(_ id: String) -> Biome {
        return Biome(id: "minecraft." + id)
    }

    static let badlands = get("badlands")
    static let bambooJungle = get("bambooJungle")
    static let basaltDeltas = get("basaltDeltas")
    static let beach = get("beach")
    static let birchForest = get("birchForest")
    static let cherryGrove = get("cherryGrove")
    static let coldOcean = get("coldOcean")
    static let crimsonForest = get("crimsonForest")
    static let darkForest = get("darkForest")
    static let deepColdOcean = get("deepColdOcean")
    static let deepDark = get("deepDark")
    static let deepFrozenOcean = get("deepFrozenOcean")
    static let deepLukewarmOcean = get("deepLukewarmOcean")
    static let deepOcean = get("deepOcean")
    static let desert = get("desert")
    static let dripstoneCaves = get("dripstoneCaves")
    static let endBarrens = get("endBarrens")
    static let endHighlands = get("endHighlands")
    static let endMidlands = get("endMidlands")
    static let erodedBadlands = get("erodedBadlands")
    static let flowerForest = get("flowerForest")
    static let forest = get("forest")
    static let frozenOcean = get("frozenOcean")
    static let frozenPeaks = get("frozenPeaks")
    static let frozenRiver = get("frozenRiver")
    static let grove = get("grove")
    static let iceSpikes = get("iceSpikes")
    static let jaggedPeaks = get("jaggedPeaks")
    static let jungle = get("jungle")
    static let lukewarmOcean = get("lukewarmOcean")
    static let lushCaves = get("lushCaves")
    static let mangroveSwamp = get("mangroveSwamp")
    static let meadow = get("meadow")
    static let mushroomFields = get("mushroomFields")
    static let netherWastes = get("netherWastes")
    static let ocean = get("ocean")
    static let oldGrowthBirchForest = get("oldGrowthBirchForest")
    static let oldGrowthPineTaiga = get("oldGrowthPineTaiga")
    static let oldGrowthSpruceTaiga = get("oldGrowthSpruceTaiga")
    static let plains = get("plains")
    static let river = get("river")
    static let savanna = get("savanna")
    static let savannaPlateau = get("savannaPlateau")
    static let smallEndIslands = get("smallEndIslands")
    static let snowyBeach = get("snowyBeach")
    static let snowyPlains = get("snowyPlains")
    static let snowySlopes = get("snowySlopes")
    static let snowyTaiga = get("snowyTaiga")
    static let soulSandValley = get("soulSandValley")
    static let sparseJungle = get("sparseJungle")
    static let stonyPeaks = get("stonyPeaks")
    static let stonyShore = get("stonyShore")
    static let sunflowerPlains = get("sunflowerPlains")
    static let swamp = get("swamp")
    static let taiga = get("taiga")
    static let theEnd = get("theEnd")
    static let theVoid = get("theVoid")
    static let warmOcean = get("warmOcean")
    static let warpedForest = get("warpedForest")
    static let windsweptForest = get("windsweptForest")
    static let windsweptGravellyHills = get("windsweptGravellyHills")
    static let windsweptHills = get("windsweptHills")
    static let windsweptSavanna = get("windsweptSavanna")
    static let woodedBadlands = get("woodedBadlands")
}