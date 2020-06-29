//
//  WordSelectionViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 28/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

protocol WordSelectionViewControllerDelegate: class {
    func wordSelectionViewController(viewController: WordSelectionViewController, didSelectWord word: String)
}

class WordSelectionViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: WordSelectionViewControllerDelegate?
    var gameModel: GameModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hideEmptyCells()
    }
}

extension WordSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameModel?.words.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as SubjectSelectCell
        
        let word = gameModel?.words[DBManager.getSavedLevel()][indexPath.row]
        let iconString = gameModel?.allSubjects[DBManager.getSavedLevel()].icon
        cell.configure(viewModel: SubjectSelectCell.ViewModel(title: word, icon: iconString))
        
        return cell
    }
}

extension WordSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DBManager.saveWord(word: indexPath.row)
        delegate?.wordSelectionViewController(viewController: self, didSelectWord: gameModel?.words[DBManager.getSavedLevel()][indexPath.row] ?? "")
    }
}
