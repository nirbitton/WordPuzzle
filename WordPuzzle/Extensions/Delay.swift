//
//  Delay.swift
//  WordPuzzle
//
//  Created by nir bitton on 23/07/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import Foundation

func delay(_ delay:Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
