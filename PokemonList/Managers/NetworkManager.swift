//
//  NetworkManager.swift
//  PokemonList
//
//  Created by patricia.martinez on 26/6/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://pokeapi.co/api/v2/pokemon"
    var pokemon: PokemonCharacteristics?
    private init() {}
    
    func getPokemons(completed: @escaping (ApiPokemonResponse?, PLError?) -> Void){
        let endpoint = baseURL
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidRequest)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
                        
            guard let data = data else {
                completed(nil, .invalidData)
                return 
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemons = try decoder.decode(ApiPokemonResponse.self, from: data)
                completed(pokemons,nil)
                
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()
    }
    
    func getPokemonByName(name: String, completed: @escaping (PokemonCharacteristics?,PLError?) -> Void){
        let endpoint = "\(baseURL)/\(name)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidRequest)
            return 
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
                        
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(PokemonDTO.self, from: data)
                completed(PokemonCharacteristics(from: pokemon),nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()
    }
}
