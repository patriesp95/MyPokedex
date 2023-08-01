//
//  MainLogicProviderTests.swift
//  MainLogicProviderTests
//
//  Created by patricia.martinez on 4/7/23.
//

import XCTest
@testable import PokemonList

final class MainLogicProviderTests: XCTestCase {
    
    var sut: MainLogicProvider!
    
    override func setUpWithError() throws {
        sut = MainLogicProvider(networkManager: NetworkManager.shared)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchPokemons(){

        //given
        let givenPokemons = [
        
        
            Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            Pokemon(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
            Pokemon(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/")
        
        ]
        sut.fetchPokemons()
        
        XCTAssertEqual(sut.pokemons, givenPokemons, "Not equals")

    }
    
    
    
    class MainLogicProviderProtocolMock: MainLogicProviderDelegateProtocol {
        var requestIsFinishedCalled: Bool = false
        var pokemonIsReadyCalled: Bool = false
        
        func requestIsFinished() {
            requestIsFinishedCalled = true
        }
        
        func pokemonIsReady(){
            pokemonIsReadyCalled = true
        }
        
        
    }
}
