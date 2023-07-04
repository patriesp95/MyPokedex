//
//  MainLogicProvider.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation

class MainLogicProvider {
    var pokemons: [Pokemon]?
    var pokemon: PokemonCharacteristics?
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }
    
    func fetchPokemons(){
        networkManager.getPokemons { pokemons, errorMessage in
            
            guard let pokemons = pokemons?.results else {
                print("an error ocurred. Couldnt retrieve pokemons properly")
                return
            }
            
            self.pokemons = pokemons
            
        }
    }
    
    func fetchPokemon(name: String){
        networkManager.getPokemonByName(name: name) { pokemon, errorMessage in
            guard let pokemon = pokemon else {
                print("an error ocurred. Couldnt retrieve pokemon properly")
                return
            }
            self.pokemon = pokemon
        }
    }
}
