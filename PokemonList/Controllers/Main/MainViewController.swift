//
//  ViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit

class MainViewController: UIViewController {
    
    var result: ApiGenericResponse?
    var pokemons = [ApiPokemonResponse]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        configure()
    }

    private func configure(){
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
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pokemons[indexPath.row].name
        return cell
    }
  
}

