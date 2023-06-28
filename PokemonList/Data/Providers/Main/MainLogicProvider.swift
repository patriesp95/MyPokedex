//
//  MainLogicProvider.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation

class MainLogicProvider {
    var pokemons: [Pokemon] = []
    
    init(pokemons: [Pokemon]){
        self.pokemons = pokemons
    }
    
    func fetchPokemons(){
        NetworkManager.shared.getPokemons { pokemons, errorMessage in
            guard let pokemons = pokemons?.results else {
                print("an error ocurred. Couldnt retrieve pokemons properly")
                return
            }
            
            self.pokemons.append(contentsOf: pokemons)
            
        }
    }
}
