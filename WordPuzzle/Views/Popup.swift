//
//  Popup.swift
//  WordPuzzle
//
//  Created by nir bitton on 01/07/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

class Popup: UIView {
    
    @IBOutlet var popup: Popup!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scorePointsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    private func commonInit() {
        Bundle.main.loadNibNamed("Popup", owner: self, options: nil)
        
        popup.frame = self.bounds
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        frame = UIScreen.main.bounds
        addSubview(popup)
        
        popup.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        popup.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        popup.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        popup.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        animateIn()
        
    }
    
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.popup.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn() {
        self.popup.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 00, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.popup.transform = .identity
            self.alpha = 1
            delay(0.5) {
                self.scorePointsLabel.text = String(DBManager.getScore())
            }
        })
    }
}
