//
//  PokemonAbility.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct PokemonAbility: Decodable {
    var ability: Ability
}

struct Ability: Decodable {
    var name: String
    var url: String
}



