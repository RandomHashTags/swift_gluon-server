//
//  PerlinNoiseGenerator.swift
//  
//
//  Created by Evan Anderson on 3/1/23.
//

import Foundation

class PerlinNoise { // Generated by ChatGPT
    private var permutation: [Int]
    
    init(seed: UInt64) {
        permutation = Array(0..<256)
        var generator:Xoroshiro128Plus = Xoroshiro128Plus(seed: seed)
        permutation.shuffle(using: &generator)
        permutation += permutation
    }
    
    private func fade(_ t: Double) -> Double {
        return t * t * t * (t * (t * 6 - 15) + 10)
    }
    
    private func lerp(_ t: Double, _ a: Double, _ b: Double) -> Double {
        return a + t * (b - a)
    }
    
    private func grad(_ hash: Int, _ x: Double, _ y: Double, _ z: Double) -> Double {
        let h = hash & 15
        let u = h < 8 ? x : y
        let v = h < 4 ? y : h == 12 || h == 14 ? x : z
        return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v)
    }
    
    private func perlin(_ x: Double, _ y: Double, _ z: Double) -> Double {
        let X = Int(floor(x)) & 255
        let Y = Int(floor(y)) & 255
        let Z = Int(floor(z)) & 255
        let x = x - floor(x)
        let y = y - floor(y)
        let z = z - floor(z)
        let u = fade(x)
        let v = fade(y)
        let w = fade(z)
        let A = permutation[X] + Y
        let AA = permutation[A] + Z
        let AB = permutation[A + 1] + Z
        let B = permutation[X + 1] + Y
        let BA = permutation[B] + Z
        let BB = permutation[B + 1] + Z
        
        return lerp(w, lerp(v, lerp(u, grad(permutation[AA], x, y, z), grad(permutation[BA], x - 1, y, z)), lerp(u, grad(permutation[AB], x, y - 1, z), grad(permutation[BB], x - 1, y - 1, z))), lerp(v, lerp(u, grad(permutation[AA + 1], x, y, z - 1), grad(permutation[BA + 1], x - 1, y, z - 1)), lerp(u, grad(permutation[AB + 1], x, y - 1, z - 1), grad(permutation[BB + 1], x - 1, y - 1, z - 1))))
    }
    
    func octavePerlin(x: Double, y: Double, z: Double, octaves: Int, persistence: Double) -> Double {
        var total: Double = 0
        var frequency: Double = 1
        var amplitude: Double = 1
        var maxValue: Double = 0
        for _ in 0..<octaves {
            total += perlin(x * frequency, y * frequency, z * frequency) * amplitude
            maxValue += amplitude
            amplitude *= persistence
            frequency *= 2
        }
        return total / maxValue
    }
}


struct Xoroshiro128Plus : RandomNumberGenerator {
    private var state: (UInt64, UInt64)
    
    init(seed: UInt64) {
        var generator = SplitMix64(seed: seed)
        self.state = (generator.next(), generator.next())
    }
    
    mutating func next() -> UInt64 {
        let s0 = state.0
        var s1 = state.1
        let result = s0 &+ s1
        
        s1 ^= s0
        state.0 = (s0 << 55 | s0 >> 9) ^ s1 ^ (s1 << 14)
        state.1 = (s1 << 36 | s1 >> 28)
        
        return result
    }
}

struct SplitMix64 {
    private var state: UInt64
    
    init(seed: UInt64) {
        self.state = seed
    }
    
    mutating func next() -> UInt64 {
        var result = self.state
        self.state = result &+ 0x9E3779B97F4A7C15
        result ^= result >> 30
        result &* 0xBF58476D1CE4E5B9
        result ^= result >> 27
        result &* 0x94D049BB133111EB
        result ^= result >> 31
        return result
    }
}