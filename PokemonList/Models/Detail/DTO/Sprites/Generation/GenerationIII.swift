//
//  GenerationIII.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationIII {
    var emerald: Emerald
    var fireredLeafgreen: FireredLeafgreen
    var rubyShappire: RubyShappire
}

struct Emerald: Decodable {
    var front_default: URL
    var front_shiny: URL
}
struct FireredLeafgreen: Decodable {
    var back_default: URL
    var back_shiny: URL
    var front_default: URL
    var front_shiny: URL
}
struct RubyShappire: Decodable {
    var back_default: URL
    var back_shiny: URL
    var front_default: URL
    var front_shiny: URL
}

extension GenerationIII: Decodable {
    enum GenerationIIICodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubyShappire = "ruby-sapphire"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationIIICodingKeys.self)
        emerald = try values.decode(Emerald.self, forKey: .emerald)
        fireredLeafgreen = try values.decode(FireredLeafgreen.self, forKey: .fireredLeafgreen)
        rubyShappire = try values.decode(RubyShappire.self, forKey: .rubyShappire)
    }

}

