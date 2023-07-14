//
//  DataFixtures.swift
//  PokemonList
//
//  Created by patricia.martinez on 13/7/23.
//

import Foundation

class DataFixtures {
    static var validPokemonListData: Data? { return jsonDataPokemonList("PokemonList")}
    static var validPokemonData: Data? { return jsonDataPokemon("Pokemon") }
    
    private static func jsonDataPokemon(_ filename: String) -> Data? {
        let path = Bundle(for: self).path(forResource: filename, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return jsonString.data(using: .utf8)
    }
    
    private static func jsonDataPokemonList(_ filename: String) -> Data? {
        let path = Bundle(for: self).path(forResource: filename, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return jsonString.data(using: .utf8)
    }
}
