//
//  PokemonType.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct PokemonType: Decodable {
    var type: Type
}
struct Type: Codable {
    var name: String
    var url: String
}
