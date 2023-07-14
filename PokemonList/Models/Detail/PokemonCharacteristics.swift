//
//  PokemonCharacteristics.swift
//  PokemonList
//
//  Created by patricia.martinez on 30/6/23.
//

import Foundation

struct PokemonCharacteristics: Decodable, Equatable {
    static func == (lhs: PokemonCharacteristics, rhs: PokemonCharacteristics) -> Bool {
        return true
    }
    
    var name: String?
    var abilities: [PokemonAbility]?
    var types: [PokemonType]?
    var sprites: PokemonSprite?
    
    init(from dto: PokemonDTO?) {
        name = dto?.name
        abilities = dto?.abilities
        types = dto?.types
        sprites = dto?.sprites
    }
}
