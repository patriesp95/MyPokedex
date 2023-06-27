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
    
    private let pokemonLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .left
        myLabel.font = .systemFont(ofSize: 24, weight: .regular)
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

    private func setupUI(){
        self.contentView.addSubview(pokemonLabel)
        
        pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            pokemonLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            pokemonLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 16),
            pokemonLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            pokemonLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        ])
        
    }
}

