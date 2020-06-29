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
    }

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(viewModel: ViewModel) {
        titleView.text = viewModel.title
        iconImageView.image = UIImage(named: viewModel.icon ?? "")
    }

}
