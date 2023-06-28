//
//  CustomPokemonCell.swift
//  PokemonList
//
//  Created by patricia.martinez on 27/6/23.
//

import Foundation
import UIKit

class CustomPokemonCell: UITableViewCell {
    
    static let identifier = "CustomPokemonCell"
    
    let baseImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites"
    let baseURL = "https://pokeapi.co/api/v2/"
    let baseURLPokemon = "https://pokeapi.co/api/v2/pokemon/"
    
    private let pokemonImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = UIImage(systemName: "questionmark")
        return myImageView
    }()
    
    private let pokemonLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .black
        myLabel.textAlignment = .left
        myLabel.font = .systemFont(ofSize: 24, weight: .medium)
        myLabel.text = "Error"
        return myLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: String, and label: String){
        //self.pokemonImageView.image = image
        self.pokemonLabel.text = label
        self.pokemonImageView.downloaded(from: getPokemonSpriteURL(pokeURL: image))

        
    }
    
    private func getPokemonSpriteURL(pokeURL: String) -> String {
        
        var finalURL = String()
        
        let firstReplacement = String(pokeURL.dropFirst(Int(baseURL.count))) // pokemon/1/
        let secondReplacement = String(pokeURL.dropFirst(Int(baseURLPokemon.count))).dropLast(1) //1
            
        if let range = firstReplacement.range(of:secondReplacement) {
            finalURL = firstReplacement.replacingCharacters(in: range, with:"\(secondReplacement).png") // pokemon/1.png/
        }
        
        return String("\(baseImageURL)/\(finalURL)".dropLast(1)) //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png

        }

    private func setupUI(){
        self.contentView.addSubview(self.pokemonImageView)
        self.contentView.addSubview(self.pokemonLabel)
        
        self.pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        self.pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.pokemonImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            self.pokemonImageView.leadingAnchor.constraint(equalTo:self.contentView.layoutMarginsGuide.leadingAnchor),
            self.pokemonImageView.heightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.heightAnchor, constant: 90),
            self.pokemonImageView.widthAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.widthAnchor, constant: 90),
            
            self.pokemonLabel.leadingAnchor.constraint(equalTo: self.pokemonImageView.trailingAnchor, constant: 16),
            self.pokemonLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.pokemonLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 50),
            self.pokemonLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 50)
            
        ])
        
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
