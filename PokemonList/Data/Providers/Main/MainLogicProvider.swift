//
//  MainLogicProvider.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation

protocol MainLogicProviderDelegateProtocol : AnyObject {
    func requestIsFinished()
    func pokemonIsReady()
}

class MainLogicProvider {
    var pokemons: [Pokemon]?
    var pokemon: PokemonCharacteristics?
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }
    
    weak var mainDelegate: MainLogicProviderDelegateProtocol?
    
    func fetchPokemons(){
        
        networkManager.getPokemons { pokemons, errorMessage in
            
            guard let pokemons = pokemons?.results else {
                print("an error ocurred. Couldnt retrieve pokemons properly")
                return
            }
            
            self.pokemons = pokemons
            
            if self.pokemons?.count ?? .zero > .zero {
                self.mainDelegate?.requestIsFinished()
            }
        }
        
    }
    
    func fetchPokemon(name: String){
        networkManager.getPokemonByName(name: name) { pokemon, errorMessage in
            guard let pokemon = pokemon else {
                print("an error ocurred. Couldnt retrieve pokemon properly")
                return
            }
            self.pokemon = pokemon
            
            if self.pokemon != nil {
                self.mainDelegate?.pokemonIsReady()
            }
        }
    }
}
