//
//  PokemonIndex.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct PokemonIndex: Decodable {
    var game_index: Int
    var version: Version
}

struct Version: Decodable {
    var name: String
    var url: String
}
