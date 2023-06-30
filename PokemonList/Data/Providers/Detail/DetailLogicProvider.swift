//
//  DetailLogicProvider.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation

class DetailLogicProvider {
    var pokemonName: String
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }

    func fetchPokemon(name: String){
        NetworkManager.shared.getPokemonByName(name: name) { pokemon, errorMessage in
            guard let pokemon = pokemon else {
                print("an error ocurred. Couldnt retrieve pokemon properly")
                return
            }
            print(pokemon)
        }
    }
}
