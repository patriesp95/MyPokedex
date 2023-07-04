//
//  ViewController.swift
//  PokemonList
//
//  Created by patricia.martinez on 23/6/23.
//

import UIKit

class MainViewController: UIViewController {
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(CustomPokemonCell.self, forCellReuseIdentifier: CustomPokemonCell.identifier)
        return tableView
    }()
    
    init?(mainLogicProvider: MainLogicProvider) {
        self.mainLogicProvider = mainLogicProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var mainLogicProvider: MainLogicProvider


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupUI()
        getPokemons()
    }

    func configurePokemonTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

    private func setupUI(){
        view.backgroundColor = .systemPink
        configurePokemonTableView()
    }
    
    func getPokemons(){
        self.mainLogicProvider.fetchPokemons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("pokemonList: \(self.mainLogicProvider.pokemons)")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainLogicProvider.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CustomPokemonCell.identifier, for: indexPath) as? CustomPokemonCell else {
            fatalError("Could not dequeue CustomPokemonCell. Try Again")
        }
                
        cell.configure(with: self.mainLogicProvider.pokemons[indexPath.row].name)
                        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        getPokemonByName(name: self.mainLogicProvider.pokemons[indexPath.row].name)
        
        guard let pokemon = self.mainLogicProvider.pokemon else { return }
                
        guard let detailViewController = DetailViewController(
            detailLogicProvider: DetailLogicProvider(pokemon: pokemon))
        else { return }
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    func getPokemonByName(name: String){
        self.mainLogicProvider.fetchPokemon(name: name)
    }
  
}

