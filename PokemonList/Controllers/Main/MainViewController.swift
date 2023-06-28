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
        
        mainLogicProvider.fetchPokemons()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainLogicProvider.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CustomPokemonCell.identifier, for: indexPath) as? CustomPokemonCell else {
            fatalError("Could not dequeue CustomPokemonCell. Try Again")
        }
                
        cell.configure(with: mainLogicProvider.pokemons[indexPath.row].name)
                        
        return cell
    }
  
}

