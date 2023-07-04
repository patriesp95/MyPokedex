//
//  DetailLogicProvider.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation

protocol DetailLogicProviderDelegateProtocol : AnyObject {
    func pokemonIsReady()
}

class DetailLogicProvider {
    var pokemon: PokemonCharacteristics
        
    init(pokemon: PokemonCharacteristics) {
        self.pokemon = pokemon
    }

}
