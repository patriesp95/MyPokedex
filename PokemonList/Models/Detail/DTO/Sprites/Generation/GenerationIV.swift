//
//  GenerationIV.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationIV  {
    var diamondPearl: DiamondPearl
    var heartgoldSoulsilver: HeartgoldSoulsilver
    var platinum: Platinum
}

struct DiamondPearl: Decodable {
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

struct HeartgoldSoulsilver: Decodable {
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

struct Platinum: Decodable {
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}


extension GenerationIV : Decodable {
    enum GenerationIVCodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationIVCodingKeys.self)
        diamondPearl = try values.decode(DiamondPearl.self, forKey: .diamondPearl)
        heartgoldSoulsilver = try values.decode(HeartgoldSoulsilver.self, forKey: .heartgoldSoulsilver)
        platinum = try values.decode(Platinum.self, forKey: .platinum)
    }

    
}
