///Users/patricia.martinez/Desktop/PokemonList.xcodeproj
//  DetailViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit



class DetailViewController: UIViewController {
    
    private let pokemonCharacteristicsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.font = .systemFont(ofSize: 24, weight: .regular)
        myLabel.text = "No Pokemon"
        return myLabel
    }()
    
    
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
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(pokemonCharacteristicsLabel)
        pokemonCharacteristicsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            pokemonCharacteristicsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonCharacteristicsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pokemonCharacteristicsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonCharacteristicsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
        
        pokemonCharacteristicsLabel.text = self.detailLogicProvider.pokemon.name
        
    }


}
