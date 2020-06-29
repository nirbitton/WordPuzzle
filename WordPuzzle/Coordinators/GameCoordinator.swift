//
//  GameCoordinator.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class GameCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var gameModel: GameModel
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        gameModel = GameModel()
    }
    
    func start() {
        showWelcomeViewController()
    }
    
    func showWelcomeViewController() {
        let welcomeViewController = WelcomeViewController.instantiate()
        welcomeViewController.delegate = self
        navigationController.pushViewController(welcomeViewController, animated: false)
    }

    func showSubjectSelectionViewController() {
        let subjectSelectionViewController = SubjectSelectionViewController.instantiate()
        subjectSelectionViewController.delegate = self
        subjectSelectionViewController.gameModel = gameModel
        navigationController.pushViewController(subjectSelectionViewController, animated: false)
    }

    func showLevelSelectionViewController() {
        let levelSelectionViewController = LevelSelectionViewController.instantiate()
        levelSelectionViewController.delegate = self
        navigationController.pushViewController(levelSelectionViewController, animated: false)
    }

    func showWordSelectionViewController() {
        let wordSelectionViewController = WordSelectionViewController.instantiate()
        wordSelectionViewController.delegate = self
        wordSelectionViewController.gameModel = gameModel
        navigationController.pushViewController(wordSelectionViewController, animated: true)
    }
    
    func showGameViewController() {
        let gameViewController = GameViewController.instantiate()
        gameViewController.selectedWordPosition = DBManager.getSavedWord()
        gameViewController.words = gameModel.words[DBManager.getSavedLevel()]
        navigationController.pushViewController(gameViewController, animated: true)
    }
}

extension GameCoordinator: LevelSelectionViewControllerDelegate {
    func levelSelectionViewController(controller: LevelSelectionViewController, didSelectLevel: Bool) {
        showSubjectSelectionViewController()
    }
}

extension GameCoordinator: WelcomeViewControllerDelegate {
    func welcomeViewController(controller: WelcomeViewController, didSelectStart: Bool) {
        showLevelSelectionViewController()
    }
    
    func welcomeViewController(controller: WelcomeViewController, didSelectAddHints: Bool) {
        
    }
}

extension GameCoordinator: SubjectSelectionViewControllerDelegate {
    func subjectSelectionViewController(viewController: SubjectSelectionViewController, didSelectSubject subject: GameModel.SubjectType) {
        showWordSelectionViewController()
    }
}

extension GameCoordinator: WordSelectionViewControllerDelegate {
    func wordSelectionViewController(viewController: WordSelectionViewController, didSelectWord word: String) {
        showGameViewController()
    }
}
