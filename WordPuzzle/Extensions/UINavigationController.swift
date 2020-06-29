//
//  UINavigationController.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 24/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

extension UINavigationController {
    func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear

        let backIndicatorImage = UIImage(named: "arrow")
        appearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)

        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.tintColor = UIColor(named: "softBlack")
    }

}

