///Users/patricia.martinez/Desktop/PokemonList.xcodeproj
//  DetailViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    init?(detailLogicProvider: DetailLogicProvider) {
        self.detailLogicProvider = detailLogicProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var detailLogicProvider: DetailLogicProvider

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        detailLogicProvider.fetchPokemon(name: self.detailLogicProvider.pokemonName)
    }

}
