//
//  GenerationI.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct GenerationI {
    var redBlue: RedBlue
    var yellow: Yellow
}

struct RedBlue: Decodable {
    var back_default: URL
    var back_gray: URL
    var back_transparent: URL
    var front_default: URL
    var front_gray: URL
    var front_transparent: URL
}

struct Yellow: Decodable {
    var back_default: URL
    var back_gray: URL
    var back_transparent: URL
    var front_default: URL
    var front_gray: URL
    var front_transparent: URL
}

extension GenerationI: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenerationICodingKeys.self)
        redBlue = try container.decode(RedBlue.self, forKey: .redBlue)
        yellow = try container.decode(Yellow.self, forKey: .yellow)
    }
 
    enum GenerationICodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}
