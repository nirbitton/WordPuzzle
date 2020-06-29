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

    var delegate: WelcomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func startAction(_ sender: Any) {
        delegate?.welcomeViewController(controller: self, didSelectStart: true)
    }

    @IBAction private func hintAction(_ sender: Any) {
        delegate?.welcomeViewController(controller: self, didSelectAddHints: true)
    }
}
