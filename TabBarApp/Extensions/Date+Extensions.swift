//
//  Date+Extensions.swift
//  TabBarApp
//
//  Created by Greg Delgado on 10/2/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

extension Date {
    static func random() -> Date {
        let interval = Date.timeIntervalSinceReferenceDate        
        let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
        return Date.init(timeIntervalSinceReferenceDate: randomInterval)
    }
}
