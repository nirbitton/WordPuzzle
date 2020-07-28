//
//  UIColor.swift
//  WordPuzzle
//
//  Created by Bitton, Nir on 24/06/2020.
//  Copyright © 2020 Bitton, Nir. All rights reserved.
//

import UIKit

// MARK: - Color assets

extension UIColor {
    static let letterNotSelected = UIColor(named: "letterNotSelected")!
    static let letterSelected = UIColor(named: "letterSelected")!
    static let hintNumber = UIColor(named: "hintNumber")!
    static let accent2Light = UIColor(named: "accent2Light")!
    static let accent3 = UIColor(named: "accent3")!
    static let accent3Light = UIColor(named: "accent3Light")!
    static let accent4 = UIColor(named: "accent4")!
    static let accentsubtitle = UIColor(named: "accentsubtitle")!
    static let accent4Light = UIColor(named: "accent4Light")!
    static let accentText = UIColor(named: "accentText")!
    static let accentTextLight = UIColor(named: "accentTextLight")!
    static let background = UIColor(named: "background")!
    static let black20 = UIColor(named: "black20")!
    static let black30 = UIColor(named: "black30")!
    static let black38 = UIColor(named: "black38")!
    static let black54 = UIColor(named: "black54")!
    static let black80 = UIColor(named: "black80")!
    static let black05 = UIColor(named: "black5")!
    static let borderGrey = UIColor(named: "borderGrey")!
    static let newBlack = UIColor(named: "newBlack")!
    static let dark = UIColor(named: "dark")!
    static let darkBlue = UIColor(named: "darkBlue")!
    static let darkInactive = UIColor(named: "darkInactive")!
    static let gray50 = UIColor(named: "gray50")!
    static let light = UIColor(named: "light")!
    static let white40 = UIColor(named: "white40")!
    static let white70 = UIColor(named: "white70")!
    static let whiteTwo = UIColor(named: "whiteTwo")!
    static let grayishBrown = UIColor(named: "grayishBrown")!
    static let warmGray = UIColor(named: "warmGray")!
    static let approvedBadge = UIColor(named: "approvedBadge")!
    static let pendingBadge = UIColor(named: "pendingBadge")!
    static let rideRequestBlue = UIColor(named: "rideRequestBlue")!
    static let rideOfferGreen = UIColor(named: "rideOfferGreen")!
    static let declinedBadge = UIColor(named: "declinedBadge")!
    static let shadowGray = UIColor(named: "shadowGray")!
    static let solo1 = UIColor(named: "solo1")!
    static let solo2 = UIColor(named: "solo2")!
    static let charcoalGrey = UIColor(named: "charcoalGrey")!
    static let charcoalGrey50 = UIColor(named: "charcoalGrey50")!
    static let offWhite = UIColor(white: 245.0 / 255.0, alpha: 1.0)
    static let deleteCancel = UIColor(red: 235.0 / 255.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    static let dandelion = UIColor(named: "dandelion")!
    static let redBadgeColor = UIColor(red: 237.0 / 255.0, green: 8.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    static let redLastSeatColor = UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    static let darkPurple = UIColor(red: 64.0 / 255.0, green: 53.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    static let requestedRideDeepBlue = UIColor(named: "requestedRideDeepBlue")!
    static let pendingRequestedRide = UIColor(named: "pendingRequestedRide")!
    static let driverInfoBackgroundColor: UIColor = UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    static let driverInfoLineColor: UIColor = UIColor(red: 231.0 / 255.0, green: 230.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    static let grayLight: UIColor = UIColor(red: 112.0 / 255.0, green: 103.0 / 255.0, blue: 131.0 / 255.0, alpha: 1.0)
}

// MARK: - Utilities

extension UIColor {
    func solidColor(on background: UIColor = .white) -> UIColor {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var backgroundRed = CGFloat(0)
        var backgroundGreen = CGFloat(0)
        var backgroundBlue = CGFloat(0)
        var backgroundAlpha = CGFloat(0)
        background.getRed(&backgroundRed, green: &backgroundGreen, blue: &backgroundBlue, alpha: &backgroundAlpha)

        let alphaInverse = 1 - alpha
        red = red * alpha + alphaInverse * backgroundRed
        green = green * alpha + alphaInverse * backgroundGreen
        blue = blue * alpha + alphaInverse * backgroundBlue

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

