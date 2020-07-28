//
//  WordCell.swift
//  WordPuzzle
//
//  Created by nir bitton on 22/07/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    struct ViewModel {
        var title: String?
        var icon: String?
        var isLocked = true
    }

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!

    func configure(viewModel: ViewModel) {
        titleView.text = viewModel.isLocked ? "" :  viewModel.title
        lockImageView.isHidden = !viewModel.isLocked
        iconImageView.image = UIImage(named: viewModel.icon ?? "")
        iconImageView.alpha = viewModel.isLocked ? 0.9 : 1.0
        isUserInteractionEnabled = viewModel.isLocked ? false : true
    }

}
