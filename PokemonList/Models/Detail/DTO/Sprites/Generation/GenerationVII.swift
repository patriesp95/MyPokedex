//
//  GenerationVII.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationVII {
    var icons: Icons
    var ultraSunUltraMoon: UltraSunUltraMoon
}

struct UltraSunUltraMoon: Decodable {
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

extension GenerationVII: Decodable {
    
    enum GenerationVIICodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationVIICodingKeys.self)
        ultraSunUltraMoon = try values.decode(UltraSunUltraMoon.self, forKey:.ultraSunUltraMoon )
        icons = try values.decode(Icons.self, forKey: .icons)
    }
    
}
