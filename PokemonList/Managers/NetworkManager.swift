//
//  NetworkManager.swift
//  PokemonList
//
//  Created by patricia.martinez on 26/6/23.
//


import Foundation


protocol NetworkManagerProtocol {
    func getPokemons(completed: @escaping (Result<ApiPokemonResponse?, PLError>) -> Void)
    func getPokemonByName(name: String, completed: @escaping (Result<PokemonCharacteristics?,PLError>) -> Void)
}



class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    let baseURL = "https://pokeapi.co/api/v2/pokemon"
    var pokemon: PokemonCharacteristics?
    private init() {}
    
    func getPokemons(completed: @escaping (Result<ApiPokemonResponse?, PLError>) -> Void){
        let endpoint = "\(baseURL)?limit=5"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
                        
            guard let data = data else {
                completed(.failure(.invalidData))
                return 
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemons = try decoder.decode(ApiPokemonResponse.self, from: data)
                completed(.success(pokemons))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getPokemonByName(name: String, completed: @escaping (Result<PokemonCharacteristics?,PLError>) -> Void){
        let endpoint = "\(baseURL)/\(name)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return 
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
                        
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(PokemonCharacteristics.self, from: data)
                completed(.success(pokemon))
            } catch {
                completed(.failure(.invalidData))

            }
        }
        
        task.resume()
    }
}
