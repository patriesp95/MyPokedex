//
//  PokemonCharacteristics.swift
//  PokemonList
//
//  Created by patricia.martinez on 30/6/23.
//

import Foundation

struct PokemonCharacteristics {
    var id: Int?
    var name: String?
    var height: Int?
    var weight: Int?
    var abilities: [PokemonAbility]?
    var types: [PokemonType]?
    var sprites: PokemonSprite?
    
    init(from dto: PokemonDTO?) {
        id = dto?.id
        name = dto?.name
        height = dto?.height
        weight = dto?.weight
        abilities = dto?.abilities
        types = dto?.types
        sprites = dto?.sprites
    }
}
