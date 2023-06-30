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
    
    private let pokemonImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = UIImage(systemName: "questionmark")
        return myImageView
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
        view.backgroundColor = .systemBlue
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(pokemonCharacteristicsLabel)
        view.addSubview(pokemonImageView)
        
        pokemonCharacteristicsLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonCharacteristicsLabel.topAnchor.constraint(equalTo: self.pokemonImageView.bottomAnchor, constant: -300),
            pokemonCharacteristicsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pokemonCharacteristicsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonCharacteristicsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
        
        pokemonCharacteristicsLabel.text = self.detailLogicProvider.pokemon.name
        guard let pokeURL = self.detailLogicProvider.pokemon.sprites?.front_default else { return }
        pokemonImageView.downloaded(from: pokeURL)
        
    }


}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
