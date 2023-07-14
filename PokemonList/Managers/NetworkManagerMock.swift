//
//  NetworkManagerMock.swift
//  PokemonList
//
//  Created by patricia.martinez on 13/7/23.
//

import Foundation

class NetworkManagerMock {
    var pokemonListData: ApiPokemonResponse?
    var pokemonData: Pokemon?
    var error: PLError?

    func getPokemons(completed: @escaping (Result<ApiPokemonResponse?, PLError>) -> Void){
        guard let error = error else { return }
        completed(.success(pokemonListData))
        completed(.failure(error))
    }
    
    func getPokemonByName(name: String, completed: @escaping (Result<Pokemon?,PLError>) -> Void){
        guard let error = error else { return }
        completed(.success(pokemonData))
        completed(.failure(error))
    }
}
