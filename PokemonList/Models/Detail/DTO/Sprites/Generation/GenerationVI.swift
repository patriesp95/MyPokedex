//
//  GenerationVI.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationVI {
    var omegaRubyAlphaShappire: OmegaRubyAlphaShappire
    var xy: XY
}

struct OmegaRubyAlphaShappire: Decodable {
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

struct XY: Decodable {
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

extension GenerationVI: Decodable {
    
    enum GenerationVICodingKeys: String, CodingKey {
        case omegaRubyAlphaShappire = "omegaruby-alphasapphire"
        case xy = "x-y"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationVICodingKeys.self)
        omegaRubyAlphaShappire = try values.decode(OmegaRubyAlphaShappire.self, forKey:.omegaRubyAlphaShappire )
        xy = try values.decode(XY.self, forKey: .xy)
    }
    
}
