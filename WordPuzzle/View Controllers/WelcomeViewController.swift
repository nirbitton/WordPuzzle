//
//  WelcomeViewController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

import UIKit

protocol WelcomeViewControllerDelegate: class {
    func welcomeViewController(controller: WelcomeViewController, didSelectStart: Bool)
    func welcomeViewController(controller: WelcomeViewController, didSelectAddHints: Bool)
}

class WelcomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var hintsCounterView: UIImageView!
    @IBOutlet weak var hintsCounterLabel: UILabel!
    
    var delegate: WelcomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBackButton()
    }
    
    func setupViews() {
        let numberOfHints = DBManager.getSavedHint()
        guard numberOfHints > 0 else {
            counterView.isHidden = true
            return
        }
        
        counterView.isHidden = false
        hintsCounterView.addShadow()
        hintsCounterLabel.text = "\(numberOfHints)"
    }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @IBAction private func startAction(_ sender: Any) {
        delegate?.welcomeViewController(controller: self, didSelectStart: true)
    }

    @IBAction private func hintAction(_ sender: Any) {
        delegate?.welcomeViewController(controller: self, didSelectAddHints: true)
    }
}
