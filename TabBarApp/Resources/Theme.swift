//
//  Theme.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/24/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

struct Theme {
    static let displayMode: DisplayMode = .light
    static let primaryFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    static let primaryFontColor = UIColor(white: 0.1, alpha: 1)
    static let secondaryFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    static let secondaryFontColor = UIColor(white: 0.7, alpha: 1)
    static let themeRedColor = UIColor(hex: 0xf44336)!
    static let sectionHeaderBackgroundColor = UIColor.lightGray
    static let sectionHeaderFont = UIFont.systemFont(ofSize: 14.0, weight: .light)
    static let inputElementHeight: CGFloat = 40
}
