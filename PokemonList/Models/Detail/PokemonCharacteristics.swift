//
//  PokemonCharacteristics.swift
//  PokemonList
//
//  Created by patricia.martinez on 30/6/23.
//

import Foundation

struct PokemonCharacteristics: Decodable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var abilities: [PokemonAbility]
    var types: [PokemonType]
    var sprites: PokemonSprite
}
