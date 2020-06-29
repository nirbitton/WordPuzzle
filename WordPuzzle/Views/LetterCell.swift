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
        var isSelected: Bool
        var tag: Int
    }

    func configure(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.isSelected ? .letterSelected : .letterNotSelected
        image.image = viewModel.isSelected ? UIImage(named: "icOn") : UIImage(named: "icOff")
        tag = viewModel.tag
    }
}
