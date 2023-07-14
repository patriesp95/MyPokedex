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
        
        networkManager.getPokemons { result in
            
            switch result {
                case .success(let pokemons):
                    self.pokemons = pokemons?.results
                
                    if self.pokemons?.count ?? .zero > .zero {
                        self.mainDelegate?.requestIsFinished()
                    }
                case .failure(let error):
                    print("an error ocurred:  \(error)")
            }
        }
        
    }
    
    func fetchPokemon(name: String){
        networkManager.getPokemonByName(name: name) { result in
            
            switch result {
                case .success(let pokemon):
                    self.pokemon = pokemon
                    if self.pokemon != nil {
                        self.mainDelegate?.pokemonIsReady()
                    }
                case.failure(let error):
                    print("an error ocurred:  \(error)")
            }
        }
    }
}
