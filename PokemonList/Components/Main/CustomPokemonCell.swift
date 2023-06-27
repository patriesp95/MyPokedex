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
    
    private let pokemonImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = UIImage(systemName: "questionmark")
        return myImageView
    }()
    
    private let pokemonLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
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
    
    func configure(with image: UIImage, and label: String){
        self.pokemonImageView.image = image
        self.pokemonLabel.text = label
    }

    private func setupUI(){
        self.contentView.addSubview(self.pokemonImageView)
        self.contentView.addSubview(self.pokemonLabel)
        
        self.pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        self.pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            
//            self.pokemonImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
//            self.pokemonImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
//            self.pokemonImageView.leadingAnchor.constraint(equalTo:self.contentView.layoutMarginsGuide.leadingAnchor),
//            self.pokemonImageView.heightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.heightAnchor, constant: 90),
//            self.pokemonImageView.widthAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.widthAnchor, constant: 90),
//            
//            self.pokemonLabel.leadingAnchor.constraint(equalTo: self.pokemonImageView.trailingAnchor, constant: 16),
//            self.pokemonLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
//            self.pokemonLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor),
//            self.pokemonLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//            
//        ])
        
    }
}

