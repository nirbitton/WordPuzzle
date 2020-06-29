//
//  LevelSelectionViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

protocol LevelSelectionViewControllerDelegate: class {
    func levelSelectionViewController(controller: LevelSelectionViewController, didSelectLevel: Bool)
}
class LevelSelectionViewController: UIViewController, Storyboarded {

    weak var delegate: LevelSelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func easyLevelAction(_ sender: Any) {
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: true)
    }
    @IBAction func mediumLevelAction(_ sender: Any) {
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: true)
    }
    @IBAction func hardLevelAction(_ sender: Any) {
        delegate?.levelSelectionViewController(controller: self, didSelectLevel: true)
    }
}
