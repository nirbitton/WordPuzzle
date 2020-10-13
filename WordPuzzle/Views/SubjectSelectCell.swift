//
//  SubjectSelectCell.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 24/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class SubjectSelectCell: UITableViewCell {

    struct ViewModel {
        var title: String?
        var icon: String?
        var isLocked = true
    }

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(viewModel: ViewModel) {
        titleView.text = viewModel.title
        lockImageView.isHidden = !viewModel.isLocked
        iconImageView.image = UIImage(named: viewModel.icon ?? "")
        if viewModel.isLocked {
            isUserInteractionEnabled = true
            iconImageView.alpha = 0.9
        } else {
            isUserInteractionEnabled = false
            iconImageView.alpha = 1.0
        }
    }

}
