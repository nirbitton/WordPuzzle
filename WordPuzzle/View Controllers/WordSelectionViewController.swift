//
//  WordSelectionViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 28/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

protocol WordSelectionViewControllerDelegate: class {
    func wordSelectionViewController(viewController: WordSelectionViewController, didSelectWord wordPosition: Int)
}

class WordSelectionViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: WordSelectionViewControllerDelegate?
    var gameModel: GameModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setupBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hideEmptyCells()
    }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension WordSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameModel?.words[DBManager.savedSubject()].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as WordCell
        
        let word = gameModel?.words[DBManager.savedSubject()][indexPath.row]
        let iconString = gameModel?.wordIcon
        cell.configure(viewModel: WordCell.ViewModel(title: word, icon: iconString, isLocked: DBManager.getSavedWord() <= indexPath.row))
        if DBManager.getSavedWord() == indexPath.row {
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
}

extension WordSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.wordSelectionViewController(viewController: self, didSelectWord: indexPath.row)
    }
}
