//
//  NetworkManager.swift
//  PokemonList
//
//  Created by patricia.martinez on 26/6/23.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://pokeapi.co/api/v2/pokemon"
    let pokeBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/"
    private init() {}
    
    func getPokemons(completed: @escaping (ApiGenericResponse?, String?) -> Void){
        let endpoint = baseURL
        //let endpoint = "\(baseURL)?limit=5"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
                        
            guard let data = data else {
                completed(nil, "The data received from the server was invalidad. Please try again.")
                return 
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemons = try decoder.decode(ApiGenericResponse.self, from: data)
                completed(pokemons,nil)
                
             
                
            } catch {
                completed(nil, "The data received from the server was invalidad. Please try again.")
            }
        }
        
        task.resume()
    }
    
}
