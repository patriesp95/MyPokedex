///Users/patricia.martinez/Desktop/PokemonList.xcodeproj
//  DetailViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit



class DetailViewController: UIViewController {
    
    private let pokemonAbilityLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.font = .systemFont(ofSize: 18, weight: .regular)
        myLabel.text = "No Ability"
        return myLabel
    }()
    
    private let pokemonTypeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.font = .systemFont(ofSize: 18, weight: .regular)
        myLabel.text = "No Type"
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
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func configureLogoImageView(){
        view.addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configurePokemonTypeLabel(){
        view.addSubview(pokemonTypeLabel)
        pokemonTypeLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            pokemonTypeLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 48),
            pokemonTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pokemonTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pokemonTypeLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configurePokemonAbilityLabel(){
        view.addSubview(pokemonAbilityLabel)
        pokemonAbilityLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            pokemonAbilityLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            pokemonAbilityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pokemonAbilityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pokemonAbilityLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureBackButton(){
        if self.navigationController?.viewControllers.first === self {
            self.navigationItem.leftBarButtonItem?.action = #selector(dismissAction)
        } else {
            self.navigationItem.leftBarButtonItem?.action = #selector(popAction)
        }
        
    }
    
    @objc func popAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
     
    
    private func setupUI(){
        
        configureLogoImageView()
        configurePokemonTypeLabel()
        configurePokemonAbilityLabel()
        configureBackButton()
        
        pokemonTypeLabel.text = "Type: \(self.detailLogicProvider.pokemon.types?.first?.type.name ?? "No Type")"
        pokemonAbilityLabel.text = "Main ability: \(self.detailLogicProvider.pokemon.abilities?.first?.ability.name ?? "No Ability")"
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
