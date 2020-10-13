//
//  LevelSelectionViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

protocol LevelSelectionViewControllerDelegate: class {
    func levelSelectionViewController(controller: LevelSelectionViewController, didSelectLevel level: Int)
}
class LevelSelectionViewController: UIViewController, Storyboarded {

    weak var delegate: LevelSelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
    }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @IBAction func easyLevelAction(_ sender: Any) {
        DBManager.saveLevel(level: GameModel.Level.easy.rawValue)
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: GameModel.Level.easy.rawValue)
    }
    @IBAction func mediumLevelAction(_ sender: Any) {
        DBManager.saveLevel(level: GameModel.Level.medium.rawValue)
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: GameModel.Level.medium.rawValue)
    }
    @IBAction func hardLevelAction(_ sender: Any) {
        DBManager.saveLevel(level: GameModel.Level.hard.rawValue)
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: GameModel.Level.hard.rawValue)
    }
}
