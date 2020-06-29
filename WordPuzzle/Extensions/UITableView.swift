//
//  UITableView.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 24/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("failed to dequeue cell")
        }

        return cell
    }

    func hideEmptyCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
