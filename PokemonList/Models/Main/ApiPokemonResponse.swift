//
//  Result.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import Foundation


struct ApiPokemonResponse: Decodable {    
    var count: Int
    var next: String
    var previous: String?
    var results: [Pokemon]
}
