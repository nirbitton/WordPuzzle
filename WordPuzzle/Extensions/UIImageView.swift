//
//  UIImageView.swift
//  WordPuzzle
//
//  Created by nir bitton on 18/07/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

extension UIImageView {
    func shadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
