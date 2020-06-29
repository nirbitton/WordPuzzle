//
//  AppCoordinator.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 23/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        UIApplication.shared.statusBarStyle = .lightContent
    }

    func start() {
        let gameCoordinator = GameCoordinator(navigationController: navigationController)
        addChildCoordinator(gameCoordinator)
        
        gameCoordinator.start()
    }
}
