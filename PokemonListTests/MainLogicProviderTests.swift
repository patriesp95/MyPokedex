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
    private var mockNetworkManager: MockNetworkManager!
    
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = MainLogicProvider(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockNetworkManager = nil
        try super.tearDownWithError()
    }
    
    func testComparePokemons(){
        
        let givenPokemons = [

            Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            Pokemon(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
            Pokemon(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/")

        ]
        
        let exp = expectation(description: "Loading pokemons")
        mockNetworkManager.expectation = exp
        
        //when
        sut.fetchPokemons()
        
        wait(for: [exp], timeout: 1)

        //then
        XCTAssertEqual(sut.pokemons, givenPokemons, "We should have loaded exactly the same pokemons.")
        
    }
    
    func testFetchNumberOfPokemons(){
        
        let exp = expectation(description: "Loading pokemons")
        mockNetworkManager.expectation = exp
        
        //when
        sut.fetchPokemons()
        
        wait(for: [exp], timeout: 1)

        //then
        XCTAssertEqual(sut.pokemons?.count, 5, "We should have loaded exactly 5 pokemons.")
        
    }
    
    func testFetchPokemonByName(){
        
        let exp = expectation(description: "Loading pokemons")
        mockNetworkManager.expectation = exp
        
        //when
        sut.fetchPokemon(name: "charmander")
        
        wait(for: [exp], timeout: 1)

        //then
        XCTAssertEqual(sut.pokemon?.name, "charmander", "We should have loaded a pokemon whose name is charmander")
        
    }
}


private class MainLogicProviderProtocolMock: MainLogicProviderDelegateProtocol {
    var requestIsFinishedCalled: Bool = false
    var pokemonIsReadyCalled: Bool = false
    
    func requestIsFinished() {
        requestIsFinishedCalled = true
    }
    
    func pokemonIsReady(){
        pokemonIsReadyCalled = true
    }
    
    
}

private class MockNetworkManager: NetworkManagerProtocol {
    
    var expectation: XCTestExpectation?
        
    func getPokemons(completed: @escaping (Result<ApiPokemonResponse?, PLError>) -> Void){
        let myPokemons = [

            Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            Pokemon(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
            Pokemon(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/")

        ]
        
        let apiResponse = ApiPokemonResponse(count: 1281, next: "https://pokeapi.co/api/v2/pokemon?offset=5&limit=5", results: myPokemons)
    
        expectation?.fulfill()
        completed(.success(apiResponse))
    }
    
    func getPokemonByName(name: String, completed: @escaping (Result<PokemonCharacteristics?, PLError>) -> Void) {
        let myPokemon = PokemonCharacteristics(name: "charmander", abilities: [PokemonAbility(ability: Ability(name: "blaze", url: "https://pokeapi.co/api/v2/ability/66/"))], types: [PokemonType(type: PokeType(name: "fire", url: "https://pokeapi.co/api/v2/type/10/"))])
        expectation?.fulfill()
        completed(.success(myPokemon))
    }
            
}


