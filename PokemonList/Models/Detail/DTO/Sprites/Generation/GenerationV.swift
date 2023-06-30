//
//  GenerationV.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationV {
    var blackWhite: BlackWhite
}

struct BlackWhite: Decodable {
    var animated: Animated
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

struct Animated: Decodable {
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

extension GenerationV: Decodable {
    
    enum GenerationVCodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationVCodingKeys.self)
        blackWhite = try values.decode(BlackWhite.self, forKey: .blackWhite)
    }
    
}
