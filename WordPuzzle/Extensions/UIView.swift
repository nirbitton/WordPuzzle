//
//  UIView.swift
//  WordPuzzle
//
//  Created by nir bitton on 18/07/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
}
