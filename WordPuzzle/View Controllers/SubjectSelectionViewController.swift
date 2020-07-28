//
//  SubjectSelectionViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 24/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

protocol SubjectSelectionViewControllerDelegate: class {
    func subjectSelectionViewController(viewController: SubjectSelectionViewController, didSelectSubject subjectPosition: GameModel.SubjectType)
}

class SubjectSelectionViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SubjectSelectionViewControllerDelegate?
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

    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hideEmptyCells()
    }
}

extension SubjectSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameModel?.allSubjects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as SubjectSelectCell
        let subject = gameModel?.allSubjects[indexPath.row]
        cell.configure(viewModel: SubjectSelectCell.ViewModel(title: subject?.name, icon: subject?.icon, isLocked: DBManager.getSavedLevel() < indexPath.row))
        
        return cell
    }
}

extension SubjectSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.subjectSelectionViewController(viewController: self, didSelectSubject: GameModel.SubjectType.all[indexPath.row])
    }
}
