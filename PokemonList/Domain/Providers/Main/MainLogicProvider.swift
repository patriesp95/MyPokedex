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
        Task {
            do {
                guard let pokemons = try await networkManager.getPokemons() else { return }
                self.pokemons = pokemons.results
                
                if self.pokemons?.count ?? .zero > .zero {
                    self.mainDelegate?.requestIsFinished()
                }
            } catch {
                if let plError = error as? PLError {
                    print(plError)
                }
            }
        }
    }
    
    func fetchPokemon(name: String){
        Task {
            do {
                guard let pokemon = try await networkManager.getPokemonByName(name: name) else { return }
                self.pokemon = PokemonCharacteristics(from: pokemon)
                
                if self.pokemon != nil {
                    self.mainDelegate?.pokemonIsReady()
                }
            } catch {
                if let plError = error as? PLError {
                    print(plError)
                }
            }
        }
        
    }
}
