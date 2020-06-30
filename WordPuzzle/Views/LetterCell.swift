//
//  LetterCell.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 28/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class LetterCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    struct ViewModel {
        var title: String
        var tag: Int
    }

    func configure(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = .letterNotSelected
        image.image = UIImage(named: "icOff")
        tag = viewModel.tag
    }
    
    func setSelected(_ isSelected: Bool) {
        titleLabel.textColor = isSelected ? .letterSelected : .letterNotSelected
        image.image = isSelected ? UIImage(named: "icOn") : UIImage(named: "icOff")
    }
}
