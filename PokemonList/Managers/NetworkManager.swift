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
    let decoder = JSONDecoder()
    
    private init() {}
    
    func getPokemons() async throws -> ApiPokemonResponse? {
        let endpoint = baseURL
    
        guard let url = URL(string: endpoint) else {
            throw PLError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
            throw PLError.invalidResponse
        }
           
        do {
            return try decoder.decode(ApiPokemonResponse.self, from: data)
        } catch {
            throw PLError.invalidData
        }
    
    }
    
    func getPokemonByName(name: String) async throws -> PokemonDTO? {
        let endpoint = "\(baseURL)/\(name)"
        
        guard let url = URL(string: endpoint) else {
            throw PLError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
            throw PLError.invalidResponse
        }
           
        do {
            return try decoder.decode(PokemonDTO.self, from: data)
        } catch {
            throw PLError.invalidData
        }
    }
}
