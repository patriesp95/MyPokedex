//
//  ViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit

class MainViewController: UIViewController {
    
    let baseImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites"
    let baseURL = "https://pokeapi.co/api/v2/"
    let baseURLPokemon = "https://pokeapi.co/api/v2/pokemon/"
    
    var pokemons = [ApiPokemonResponse]()
    var pokemonSprites = [UIImage]()
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CustomPokemonCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getPokemons { pokemons, errorMessage in
            guard let pokemons = pokemons?.results else {
                print("an error ocurred. Couldnt retrieve pokemons properly")
                return
            }
            
            self.pokemons.append(contentsOf: pokemons)
        }
        
       
           
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupUI()
    }

    private func setupUI(){
        view.backgroundColor = .systemPink
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
    }
    
    private func getPokemonSpriteURL(pokeURL: String) -> String {
        
        var finalURL = String()
        
        let firstReplacement = String(pokeURL.dropFirst(Int(baseURL.count)))
        let secondReplacement = String(pokeURL.dropFirst(Int(baseURLPokemon.count))).dropLast(1)
            
        if let range = firstReplacement.range(of:secondReplacement) {
            finalURL = firstReplacement.replacingCharacters(in: range, with:"\(secondReplacement).png")
        }
        
        return String("\(baseImageURL)/\(finalURL)".dropLast(1))

    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomPokemonCell.identifier, for: indexPath)
        
        cell.textLabel?.text = pokemons[indexPath.row].name
        cell.imageView?.downloaded(from: getPokemonSpriteURL(pokeURL: pokemons[indexPath.row].url))
                
        return cell
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
