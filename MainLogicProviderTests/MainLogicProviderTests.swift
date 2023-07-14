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
        let delegate: MainLogicProviderProtocolMock = MainLogicProviderProtocolMock()
        guard let myPokemons = DataFixtures.validPokemonListData else { return }
        var givenPokemons: [Pokemon]? = nil
        
        sut.mainDelegate = delegate //dos objectos conectado
        
        do {
            let decoder = JSONDecoder()
            let pokemons = try decoder.decode(ApiPokemonResponse.self, from: myPokemons)
            givenPokemons = pokemons.results
        }catch {
            print("error")
        }
        
        sut.fetchPokemons()
        
        XCTAssertEqual(sut.pokemons, givenPokemons, "Not equals")

    }
    
    func testrequestIsFinishedCalled(){
                
        //given
        let delegate: MainLogicProviderProtocolMock = MainLogicProviderProtocolMock()
        
        sut.mainDelegate = delegate //dos objectos conectado
        sut.fetchPokemons()
        
        XCTAssertTrue(delegate.requestIsFinishedCalled)
    }
    
    func testFetchPokemon(){
                
        //given
        let delegate: MainLogicProviderProtocolMock = MainLogicProviderProtocolMock()
        guard let myPokemon = DataFixtures.validPokemonData else { return }
        var givenPokemon: PokemonCharacteristics? = nil
        
        sut.mainDelegate = delegate //dos objectos conectado
        
        do {
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(PokemonDTO.self, from: myPokemon)
            givenPokemon = PokemonCharacteristics(from: pokemon)
        }catch {
            print("error")
        }
        
        sut.fetchPokemon(name: "charmander")
        
        XCTAssertEqual(sut.pokemon, givenPokemon, "Not equals")
    }
    
    func testPokemonIsReady(){
                
        //given
        let delegate: MainLogicProviderProtocolMock = MainLogicProviderProtocolMock()
        
        sut.mainDelegate = delegate //dos objectos conectado
        sut.fetchPokemon(name: "charmander")
        
        XCTAssertTrue(delegate.pokemonIsReadyCalled)
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
