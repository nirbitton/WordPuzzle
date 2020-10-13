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

    func showSubjectSelectionViewController(level: Int) {
        let subjectSelectionViewController = SubjectSelectionViewController.instantiate()
        subjectSelectionViewController.delegate = self
        subjectSelectionViewController.gameModel = gameModel
        switch level {
        case 1:
            subjectSelectionViewController.savedSubject = DBManager.easySavedSubject()
        case 2:
            subjectSelectionViewController.savedSubject = DBManager.savedSubject()
        default:
            subjectSelectionViewController.savedSubject = DBManager.hardSavedSubject()
        }
        navigationController.pushViewController(subjectSelectionViewController, animated: false)
    }

    func showLevelSelectionViewController() {
        let levelSelectionViewController = LevelSelectionViewController.instantiate()
        levelSelectionViewController.delegate = self
        navigationController.pushViewController(levelSelectionViewController, animated: false)
    }

    func showWordSelectionViewController(selectedSubject: Int) {
        let wordSelectionViewController = WordSelectionViewController.instantiate()
        wordSelectionViewController.delegate = self
        wordSelectionViewController.gameModel = gameModel
        wordSelectionViewController.selectedSubject = selectedSubject
        navigationController.pushViewController(wordSelectionViewController, animated: false)
    }
    
    func showGameViewController(_ wordPosition: Int) {
        let gameViewController = GameViewController.instantiate()
        gameViewController.selectedWordPosition = wordPosition
        gameViewController.words = gameModel.words[gameModel.subject.rawValue]
        gameViewController.gameModel = gameModel
        gameViewController.selectedSubject = gameModel.subject.rawValue
        navigationController.pushViewController(gameViewController, animated: false)
    }
}

extension GameCoordinator: LevelSelectionViewControllerDelegate {
    func levelSelectionViewController(controller: LevelSelectionViewController, didSelectLevel level: Int) {
        showSubjectSelectionViewController(level: level)
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
        showWordSelectionViewController(selectedSubject: subject.rawValue)
    }
}

extension GameCoordinator: WordSelectionViewControllerDelegate {
    func wordSelectionViewController(viewController: WordSelectionViewController, didSelectWord wordPosition: Int) {
        showGameViewController(wordPosition)
    }
}
